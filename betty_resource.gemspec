# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'betty_resource/version'

Gem::Specification.new do |gem|
  gem.name        = "betty_resource"
  gem.version     = BettyResource::VERSION
  gem.authors     = ["Chiel Wester", "Stephan Kaag", "Daniel Willemse", "Paul Engel"]
  gem.email       = ["chiel.wester@holder.nl", "stephan.kaag@bettyblocks.com", "daniel.willemse@holder.nl", "paul.engel@bettyblocks.com"]
  gem.description = %q{Map Betty5 application resources to Ruby objects through the JSON API}
  gem.summary     = %q{Map Betty5 application resources to Ruby objects}
  gem.homepage    = "https://github.com/bettyblocks/betty_resource"

  gem.files       = `git ls-files`.split($/)
  gem.executables = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files  = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.platform    = Gem::Platform::RUBY

  gem.add_dependency "httparty"
  gem.add_dependency "activesupport"
  gem.add_dependency "crack"
  gem.add_dependency "dirty_hashy", "0.1.3"
  gem.add_development_dependency "minitest"
end