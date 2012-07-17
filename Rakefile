#!/usr/bin/env rake
require "bundler"
require "rake/testtask"

Bundler::GemHelper.install_tasks

task :default => :test

Rake::TestTask.new do |t|
  t.test_files = FileList["test/**/test_*.rb"]
end