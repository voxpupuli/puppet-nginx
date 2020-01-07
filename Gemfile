source ENV['GEM_SOURCE'] || "https://rubygems.org"

def location_for(place, fake_version = nil)
  if place =~ /^(git[:@][^#]*)#(.*)/
    [fake_version, { :git => $1, :branch => $2, :require => false }].compact
  elsif place =~ /^file:\/\/(.*)/
    ['>= 0', { :path => File.expand_path($1), :require => false }]
  else
    [place, { :require => false }]
  end
end

group :test do
  gem 'puppetlabs_spec_helper', '>= 2.14.0',                        :require => false
  gem 'rspec-puppet-facts', '>= 1.9.5',                             :require => false
  gem 'rspec-puppet-utils',                                         :require => false
  gem 'puppet-lint-leading_zero-check',                             :require => false
  gem 'puppet-lint-trailing_comma-check',                           :require => false
  gem 'puppet-lint-version_comparison-check',                       :require => false
  gem 'puppet-lint-classes_and_types_beginning_with_digits-check',  :require => false
  gem 'puppet-lint-unquoted_string-check',                          :require => false
  gem 'puppet-lint-variable_contains_upcase',                       :require => false
  gem 'puppet-lint-absolute_classname-check', '>= 2.0.0',           :require => false
  gem 'puppet-lint-topscope-variable-check',                        :require => false
  gem 'puppet-lint-legacy_facts-check',                             :require => false
  gem 'puppet-lint-anchor-check',                                   :require => false
  gem 'metadata-json-lint',                                         :require => false
  gem 'redcarpet',                                                  :require => false
  gem 'rubocop', '~> 0.49.1',                                       :require => false
  gem 'rubocop-rspec', '~> 1.15.0',                                 :require => false
  gem 'mocha', '~> 1.4.0',                                          :require => false
  gem 'coveralls',                                                  :require => false
  gem 'simplecov-console',                                          :require => false
  gem 'parallel_tests',                                             :require => false
end

group :development do
  gem 'travis',                   :require => false
  gem 'travis-lint',              :require => false
  gem 'guard-rake',               :require => false
  gem 'overcommit', '>= 0.39.1',  :require => false
end

group :system_tests do
  gem 'winrm',                              :require => false
  if beaker_version = ENV['BEAKER_VERSION']
    gem 'beaker', *location_for(beaker_version)
  else
    gem 'beaker', '>= 4.2.0', :require => false
  end
  if beaker_rspec_version = ENV['BEAKER_RSPEC_VERSION']
    gem 'beaker-rspec', *location_for(beaker_rspec_version)
  else
    gem 'beaker-rspec',  :require => false
  end
  gem 'serverspec',                         :require => false
  gem 'beaker-hostgenerator', '>= 1.1.22',  :require => false
  gem 'beaker-docker',                      :require => false
  gem 'beaker-puppet',                      :require => false
  gem 'beaker-puppet_install_helper',       :require => false
  gem 'beaker-module_install_helper',       :require => false
  gem 'rbnacl', '>= 4',                     :require => false
  gem 'rbnacl-libsodium',                   :require => false
  gem 'bcrypt_pbkdf',                       :require => false
  gem 'ed25519',                            :require => false
end

group :release do
  gem 'github_changelog_generator',  :require => false, :git => 'https://github.com/voxpupuli/github-changelog-generator', :branch => 'voxpupuli_essential_fixes'
  gem 'puppet-blacksmith',           :require => false
  gem 'voxpupuli-release',           :require => false
  gem 'puppet-strings', '>= 2.2',    :require => false
end



if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion.to_s, :require => false, :groups => [:test]
else
  gem 'facter', :require => false, :groups => [:test]
end

ENV['PUPPET_VERSION'].nil? ? puppetversion = '~> 6.0' : puppetversion = ENV['PUPPET_VERSION'].to_s
gem 'puppet', puppetversion, :require => false, :groups => [:test]

# vim: syntax=ruby
