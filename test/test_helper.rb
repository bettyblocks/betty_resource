ENV["RACK_ENV"] = "test"
ENV["TESTOPTS"] = "-v"

require "rubygems"
require "bundler"

require "minitest/unit"
require "minitest/autorun"

Bundler.require :gem_default, :gem_test

BettyResource.configure do |config|
  config.host     = "https://betty-resource-test.bettyblocks.com"
  config.user     = "testuser@bettyblocks.com"
  config.password = "ensure"
end