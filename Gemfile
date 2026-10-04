# Managed by modulesync - DO NOT EDIT
# https://voxpupuli.org/docs/updating-files-managed-with-modulesync/

source ENV['GEM_SOURCE'] || 'https://rubygems.org'

group :test do
  gem 'voxpupuli-test', '~> 14.0',  :require => false
  gem 'puppet_metadata', '~> 6.4',  :require => false
end

group :development do
  gem 'guard-rake',               :require => false
  gem 'overcommit', '>= 0.39.1',  :require => false
end

group :system_tests do
  gem 'voxpupuli-acceptance', '~> 4.4',  :require => false
end

group :release do
  gem 'voxpupuli-release', '~> 5.5',  :require => false
end

gem 'rake', :require => false

gem 'openvox', ENV.fetch('OPENVOX_GEM_VERSION', [">= 7", "< 10"]), :require => false, :groups => [:test]

# vim: syntax=ruby
