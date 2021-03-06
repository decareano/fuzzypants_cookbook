directory '/tmp/default_action'

directory '/tmp/explicit_action' do
  action :create
end

directory '/tmp/with_attributes' do
  user   'user'
  group  'group'
end

directory 'specifying the identity attribute' do
  path '/tmp/identity_attribute'
end

directory '/media/myrepo/with_attributes' do
  owner 'root'
  group 'root'
  mode '755'
end