ENV['RACK_ENV'] = 'test'
ENV['TESTOPTS'] = '-v'

require 'rubygems'
require 'bundler/setup'

require 'minitest/unit'
require 'minitest/autorun'

require 'simplecov'

SimpleCov.start do
  coverage_dir 'coverage'
  add_filter '/test/'
end

Bundler.require :gem_default, :gem_test
BettyResource.configure(MultiJson.decode(File.read(File.expand_path('../../.credentials', __FILE__))))
