# coding: utf-8

require "rake"
require "rspec/core/rake_task"

task :default => [:spec, :run]

desc "spec all"
RSpec::Core::RakeTask.new do |t|
  t.name = "spec"
  t.pattern = "spec/*_spec.rb"
end

desc "run"
task :run do
  sh "ruby bin/dungeon"
end

