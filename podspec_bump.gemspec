# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'podspec_bump/version'

Gem::Specification.new do |spec|
  spec.name          = "podspec_bump"
  spec.version       = PodspecBump::VERSION
  spec.authors       = ["nakajijapan"]
  spec.email         = ["pp.kupepo.gattyanmo@gmail.com"]
  spec.summary       = %q{A command line tools to bump podspec version for CocoaPods.}
  spec.description   = %q{A command line tools to bump podspec version for CocoaPods. Inspired [Bump](https://github.com/gregorym/bump)}
  spec.homepage      = "http://www.nakajijapan.net"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", '>= 0'
  spec.add_development_dependency "colorize", '>= 0'
end
