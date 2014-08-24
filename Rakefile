require 'bundler'
Bundler.require(:rake)
require 'rake/clean'

CLEAN.include('spec/fixtures/', 'doc', 'pkg')
CLOBBER.include('.tmp', '.librarian')

require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet_blacksmith/rake_tasks'
require 'rspec-system/rake_task'

task :default => [:clean, :spec]
