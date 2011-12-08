# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sprockets/plugin/version"

Gem::Specification.new do |s|
  s.name        = "sprockets-plugin"
  s.version     = Sprockets::Plugin::VERSION
  s.authors     = ["Pete Browne"]
  s.email       = ["me@petebrowne.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "sprockets-plugin"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency "sprockets", "~> 2.0"
  s.add_development_dependency "rspec",     "~> 2.6.0"
end
