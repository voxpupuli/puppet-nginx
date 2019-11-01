# This file is managed via modulesync
# https://github.com/voxpupuli/modulesync
# https://github.com/voxpupuli/modulesync_config
RSpec.configure do |c|
  c.mock_with :rspec
end

require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
require 'bundler'
include RspecPuppetFacts

if ENV['DEBUG']
  Puppet::Util::Log.level = :debug
  Puppet::Util::Log.newdestination(:console)
end

if File.exist?(File.join(__dir__, 'default_module_facts.yml'))
  facts = YAML.load(File.read(File.join(__dir__, 'default_module_facts.yml')))
  if facts
    facts.each do |name, value|
      add_custom_fact name.to_sym, value
    end
  end
end

if Dir.exist?(File.expand_path('../../lib', __FILE__))
  require 'coveralls'
  require 'simplecov'
  require 'simplecov-console'
  SimpleCov.formatters = [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Console
  ]
  SimpleCov.start do
    track_files 'lib/**/*.rb'
    add_filter '/spec'
    add_filter '/vendor'
    add_filter '/.vendor'
    add_filter Bundler.configured_bundle_path.path
  end
end

RSpec.configure do |c|
  # getting the correct facter version is tricky. We use facterdb as a source to mock facts
  # see https://github.com/camptocamp/facterdb
  # people might provide a specific facter version. In that case we use it.
  # Otherwise we need to match the correct facter version to the used puppet version.
  # as of 2019-10-31, puppet 5 ships facter 3.11 and puppet 6 ships facter 3.14
  # https://puppet.com/docs/puppet/5.5/about_agent.html
  c.default_facter_version = if ENV['FACTERDB_FACTS_VERSION']
                               ENV['FACTERDB_FACTS_VERSION']
                             else
                               Gem::Dependency.new('', ENV['PUPPET_VERSION']).match?('', '5') ? '3.11.0' : '3.14.0'
                             end

  # Coverage generation
  c.after(:suite) do
    RSpec::Puppet::Coverage.report!
  end
end
