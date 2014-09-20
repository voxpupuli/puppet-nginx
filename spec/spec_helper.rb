require 'puppetlabs_spec_helper/module_spec_helper'
require 'fixtures/modules/module_data/lib/hiera/backend/module_data_backend.rb'

RSpec.configure do |c|
  c.hiera_config = File.join('spec', 'fixtures', 'hiera', 'hiera.yaml')

  c.default_facts = {
    :kernel          => 'Linux',
    :concat_basedir  => '/var/lib/puppet/concat',
  }
end
