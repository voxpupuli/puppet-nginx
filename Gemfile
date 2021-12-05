# Managed by modulesync - DO NOT EDIT
# https://voxpupuli.org/docs/updating-files-managed-with-modulesync/

source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :test do
  gem 'voxpupuli-test', '~> 2.5',   :require => false
  gem 'coveralls',                  :require => false
  gem 'simplecov-console',          :require => false
  gem 'puppet_metadata',            :require => false, :git => 'https://github.com/bastelfreak/puppet_metadata.git', :branch => 'add-archlinux'
end

group :development do
  gem 'guard-rake',               :require => false
  gem 'overcommit', '>= 0.39.1',  :require => false
end

group :system_tests do
  gem 'beaker-hostgenerator',            :require => false, :git => 'https://github.com/ekohl/beaker-hostgenerator.git', :branch => 'add-archlinux'
  gem 'beaker',                          :require => false, :git => 'https://github.com/bastelfreak/beaker.git', :branch => 'add-archlinux'
  gem 'beaker-docker',                   :require => false, :git => 'https://github.com/bastelfreak/beaker-docker.git', :branch => 'add-archlinux'
  gem 'voxpupuli-acceptance', '~> 1.0',  :require => false
end

group :release do
  gem 'github_changelog_generator', '>= 1.16.1',  :require => false if RUBY_VERSION >= '2.5'
  gem 'voxpupuli-release', '>= 1.0.2',            :require => false
  gem 'puppet-strings', '>= 2.2',                 :require => false
end

gem 'rake', :require => false
gem 'facter', ENV['FACTER_GEM_VERSION'], :require => false, :groups => [:test]

puppetversion = ENV['PUPPET_VERSION'] || '>= 6.0'
gem 'puppet', puppetversion, :require => false, :groups => [:test]

# vim: syntax=ruby
