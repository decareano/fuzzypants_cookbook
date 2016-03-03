require 'spec_helper'

describe 'directory::create' do
  

  it 'creates a directory with the default action' do
    expect(chef_run).to create_directory('/tmp/default_action')
    expect(chef_run).to_not create_directory('/tmp/not_default_action')
  end

  it 'creates a directory with an explicit action' do
    expect(chef_run).to create_directory('/tmp/explicit_action')
  end

  it 'creates a directory with attributes' do
    expect(chef_run).to create_directory('/tmp/with_attributes').with(
      user:   'user',
      group:  'group',
    )

    expect(chef_run).to_not create_directory('/tmp/with_attributes').with(
      user:   'bacon',
      group:  'fat',
    )
  end

  it 'creates a directory when specifying the identity attribute' do
    expect(chef_run).to create_directory('/tmp/identity_attribute')
  end

  it 'creates a directory with attributes' do
    expect(chef_run).to create_directory('/media/myrepo/with_attributes').with(
    owner: 'root',
    group: 'root',
    mode: '755'
  )
  end

end