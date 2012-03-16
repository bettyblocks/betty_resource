ENV["RACK_ENV"] = "test"
ENV["TESTOPTS"] = "-v"

require "minitest/unit"
require "minitest/autorun"

require_relative "../init"

