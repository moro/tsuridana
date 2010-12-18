# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tsuridana/version"

Gem::Specification.new do |s|
  s.name        = "tsuridana"
  s.version     = Tsuridana::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["MOROHASHI Kyosuke"]
  s.email       = ["moronatural@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{parses cucumber's step_definitions.}
  s.description = %q{}

  s.rubyforge_project = "tsuridana"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
