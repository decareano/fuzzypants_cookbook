include_recipe "apt::default"
include_recipe "build-essential"


package "git"
log "well, thats too easy"

apt_package 'apache2' do
  action :install
end

package 'nginx' do
  action :install
end

#cookbook_file "/etc/nginx/sites-enabled" do
   #source "nginx.config"
   #action :create
#end

user_home = "/home/#{node['cookbook_name']['user']}"
group 'mygroup'
user node['cookbook_name']['user'] do
  gid node['cookbook_name']['group']
  shell '/bin/bash'
  home user_home
  system true
  action :create
end


directory "/media/myrepo" do
  owner 'root'
  group 'root'
  mode '755'
end


cookbook_file '/etc/index.php' do
  source 'index.php'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/etc/debconf.conf' do
  source 'debconf.conf.erb'
  #verify 'debconf -t -c %{path}'
end

template '/tmp/somefile' do
  mode '0755'
  source 'somefile.erb'
  only_if {File.exist?('/etc/passwd')} 
end




template '/tmp/baz' do
  verify { 1 == 1 }
end

directory "/file" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/file/name.txt' do
  source 'test.erb'
  variables :partials => {
    'partial_name_1.txt.erb' => 'message',
    'partial_name_2.txt.erb' => 'message',
    'partial_name_3.txt.erb' => 'message'
  }
end

node.default['nginx']['remote_ip_var'] = 'remote_addr'
node.default['nginx']['authorized_ips'] = ['127.0.0.1/32']

service 'nginx' do
  supports :status => true, :restart => true, :reload => true
end

template 'authorized_ip' do
  path "#{node['nginx']['dir']}/authorized_ip"
  source 'authorized_ip.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables(
    :remote_ip_var => node['nginx']['remote_ip_var'],
    :authorized_ips => node['nginx']['authorized_ips']
  )

  notifies :reload, 'service[nginx]', :immediately
end

#template '/etc/sudoers' do
  #source 'sudoers.erb'
  #mode '0440'
  #owner 'root'
  #group 'root'
  #variables({
     #:sudoers_groups => node[:authorization][:sudo][:groups],
     #:sudoers_users => node[:authorization][:sudo][:users]
  #})
#end

