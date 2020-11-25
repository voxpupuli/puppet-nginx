source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :test do
  gem 'voxpupuli-test', '~> 2.1',  :require => false
  gem 'coveralls',                 :require => false
  gem 'simplecov-console',         :require => false
end

group :development do
  gem 'guard-rake',               :require => false
  gem 'overcommit', '>= 0.39.1',  :require => false
end

group :system_tests do
  gem 'puppet_metadata', '~> 0.3.0',  :require => false
  gem 'voxpupuli-acceptance',         :require => false
end

group :release do
  gem 'github_changelog_generator',  :require => false, :git => 'https://github.com/voxpupuli/github-changelog-generator', :branch => 'voxpupuli_essential_fixes'
  gem 'puppet-blacksmith',           :require => false
  gem 'voxpupuli-release',           :require => false
  gem 'puppet-strings', '>= 2.2',    :require => false
end

gem 'puppetlabs_spec_helper', '~> 2.0', :require => false
gem 'rake', :require => false
gem 'facter', ENV['FACTER_GEM_VERSION'], :require => false, :groups => [:test]

puppetversion = ENV['PUPPET_VERSION'] || '~> 6.0'
gem 'puppet', puppetversion, :require => false, :groups => [:test]

# vim: syntax=ruby
