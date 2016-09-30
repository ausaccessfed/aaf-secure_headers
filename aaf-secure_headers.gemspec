# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aaf/secure_headers/version'

Gem::Specification.new do |spec|
  spec.name          = "aaf-secure_headers"
  spec.version       = AAF::SecureHeaders::VERSION
  spec.authors       = ["Ryan Caught"]
  spec.email         = ["ryan.caught@aaf.edu.au"]

  spec.summary       = %q{Base configuration for AAF Secure Headers}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/ausaccessfed/aaf-secure_headers"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "secure_headers", "~> 3.5.0.pre"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
