# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "betty_resource/version"

Gem::Specification.new do |s|
  s.name        = "betty_resource"
  s.version     = BettyResource::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chiel Wester", "Stephan Kaag", "Daniel Willemse"]
  s.email       = ["chiel.wester@holder.nl", "stephan.kaag@holder.nl", "daniel.willemse@holder.nl"]
  s.homepage    = "www.bettyblocks.com"
  s.summary     = %q{Connect to betty5 applications}
  s.description = %q{Connect to betty5 applications by specifying betty5 resource}

  s.add_dependency 'json'
  s.add_dependency 'httparty'
  s.add_dependency 'activesupport'
  s.add_dependency 'crack'

  s.add_development_dependency 'minitest'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
