# Managed by modulesync - DO NOT EDIT
# https://voxpupuli.org/docs/updating-files-managed-with-modulesync/

source ENV['GEM_SOURCE'] || 'https://rubygems.org'

group :test do
  gem 'voxpupuli-test', '~> 7.0',   :require => false
  gem 'coveralls',                  :require => false
  gem 'simplecov-console',          :require => false
  gem 'puppet_metadata',            :require => false, :git => 'https://github.com/voxpupuli/puppet_metadata.git', :ref => 'refs/pull/122/head'
end

group :development do
  gem 'guard-rake',               :require => false
  gem 'overcommit', '>= 0.39.1',  :require => false
end

group :system_tests do
  gem 'beaker',                          :require => false, :git => 'https://github.com/voxpupuli/beaker.git', :ref => 'refs/pull/1853/head'
  gem 'beaker-hostgenerator',            :require => false, :git => 'https://github.com/voxpupuli/beaker-hostgenerator.git', :ref => 'refs/pull/359/head'
  gem 'voxpupuli-acceptance', '~> 3.0',  :require => false
end

group :release do
  gem 'voxpupuli-release', '~> 3.0',  :require => false
end

gem 'rake', :require => false
gem 'facter', ENV['FACTER_GEM_VERSION'], :require => false, :groups => [:test]

puppetversion = ENV['PUPPET_GEM_VERSION'] || '~> 7.24'
gem 'puppet', puppetversion, :require => false, :groups => [:test]

# vim: syntax=ruby
