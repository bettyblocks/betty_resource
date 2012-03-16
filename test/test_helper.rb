ENV["RACK_ENV"] = "test"
ENV["TESTOPTS"] = "-v"

require "minitest/unit"
require "minitest/autorun"

require_relative "../init"

BettyResource.config.host = "betty-resource-test.bettyblocks.com"
BettyResource.config.user = "testuser@bettyblocks.com"
BettyResource.config.password = "ensure"