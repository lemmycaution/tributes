# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tributes/version'

Gem::Specification.new do |spec|
  spec.name          = "tributes"
  spec.version       = Tributes::VERSION
  spec.authors       = ["Onur Uyar"]
  spec.email         = ["me@onuruyar.com"]
  spec.summary       = %q{Ruby Exercise}
  spec.homepage      = "https://github.com/lemmycaution/tributes"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
