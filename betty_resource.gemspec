# -*- encoding: utf-8 -*-
require File.expand_path("../lib/betty_resource/version", __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Chiel Wester", "Stephan Kaag", "Daniel Willemse", "Paul Engel"]
  gem.email         = ["chiel.wester@holder.nl", "stephan.kaag@bettyblocks.com", "daniel.willemse@holder.nl", "paul.engel@bettyblocks.com"]
  gem.summary       = %q{Map Betty5 application resources to Ruby objects}
  gem.description   = %q{Map Betty5 application resources to Ruby objects through the JSON API}
  gem.homepage      = "https://github.com/bettyblocks/betty_resource"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "betty_resource"
  gem.require_paths = ["lib"]
  gem.platform      = Gem::Platform::RUBY
  gem.version       = BettyResource::VERSION

  gem.add_dependency "httparty", "0.10.0"
  gem.add_development_dependency "minitest"
end