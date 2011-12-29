# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "guard-nunit/version"

Gem::Specification.new do |s|
  s.name        = "guard-nunit"
  s.version     = Guard::NUnit::VERSION
  s.authors     = ["Mark Glenn"]
  s.email       = ["markglenn@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "guard-nunit"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", '~> 1.0'
  s.add_development_dependency "rspec", '~> 2.7'
  s.add_development_dependency "guard", '~> 0.9.4'
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "ruby_gntp"

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
