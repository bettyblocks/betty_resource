# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)
require "betty_resource/version"

Gem::Specification.new do |gem|
  gem.authors     = ["Chiel Wester", "Stephan Kaag", "Daniel Willemse", "Paul Engel"]
  gem.email       = ["chiel.wester@holder.nl", "stephan.kaag@holder.nl", "daniel.willemse@holder.nl", "paul.engel@holder.nl"]
  gem.description = %q{Map Betty5 application resources to Ruby objects through the JSON API}
  gem.summary     = %q{Map Betty5 application resources to Ruby objects}
  gem.homepage    = "http://gitlab.holder.nl/betty_resource"

  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name        = "betty_resource"
  gem.require_paths = ["lib"]
  gem.version     = BettyResource::VERSION
  gem.platform    = Gem::Platform::RUBY

  gem.add_dependency "httparty"
  gem.add_dependency "activesupport"
  gem.add_dependency "crack"
  gem.add_development_dependency "minitest"
end