# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'example_gem/version'

Gem::Specification.new do |spec|
  spec.name          = "example_gem"
  spec.version       = ExampleGem::VERSION
  spec.authors       = ["Chris Kottom"]
  spec.email         = ["chris@chriskottom.com"]
  spec.summary       = %q{Totally bogus example gem}
  spec.description   = %q{Totally bogus example gem}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 11.0"
  spec.add_development_dependency "minitest", "~> 5.9"
end
