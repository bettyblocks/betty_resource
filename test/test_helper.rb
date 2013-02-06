require "rubygems"
require "bundler"

require "minitest/unit"
require "minitest/autorun"



Bundler.require :gem_default, :gem_test
BettyResource.configure(MultiJson.decode(File.read(File.expand_path('../../.credentials', __FILE__))))