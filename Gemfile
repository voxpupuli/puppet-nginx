source 'https://rubygems.org'

group :rake do
  gem 'puppetlabs_spec_helper', '~> 1.1', :require => false
  gem 'rspec-puppet',           '~> 2.3', :require => false
  gem 'puppet-lint',            '~> 2.0', :require => false
  gem 'puppet-blacksmith',                :require => false
  gem 'rake',                             :require => false
  gem 'metadata-json-lint',               :require => false
end

group :system_tests do
  gem 'beaker-rspec', :require => false
  gem 'beaker',       :require => false
end

gem 'json_pure', '<=2.0.1', :require => false if RUBY_VERSION =~ /^1\./

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end
