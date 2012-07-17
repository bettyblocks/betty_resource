ENV["RACK_ENV"] = "test"
ENV["TESTOPTS"] = "-v"

require "rubygems"
require "bundler"

Bundler.require :gem_default, :gem_test

require "minitest/unit"
require "minitest/autorun"

BettyResource.configure do |config|
  config.host     = "https://betty-resource-test.bettyblocks.com"
  config.user     = "testuser@bettyblocks.com"
  config.password = "ensure"
end