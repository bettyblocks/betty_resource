require "rubygems"
require "bundler"

require "minitest/unit"
require "minitest/autorun"

Bundler.require :gem_default, :gem_test

if File.exists?(file = File.expand_path('../../.credentials', __FILE__))
  BettyResource.configure MultiJson.decode(File.read(file))
end

if File.exists?(file = File.expand_path('../../credentials.yaml', __FILE__))
  BettyResource.configure YAML.load_file(file)
end