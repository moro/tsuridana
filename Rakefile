require 'rubygems'
require 'bundler'
require 'rspec/core/rake_task'

task :default => :spec
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = %w[--color]
end

Bundler::GemHelper.install_tasks
