include_recipe "apt::default"
include_recipe "build-essential"


package "git"
log "well, thats too easy"

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

