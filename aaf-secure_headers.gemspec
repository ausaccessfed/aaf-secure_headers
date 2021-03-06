# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aaf/secure_headers/version'

Gem::Specification.new do |spec|
  spec.name          = 'aaf-secure_headers'
  spec.version       = AAF::SecureHeaders::VERSION
  spec.authors       = ['Ryan Caught']
  spec.email         = ['ryan.caught@aaf.edu.au']

  spec.summary       = 'Base configuration for AAF Secure Headers'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/ausaccessfed/aaf-secure_headers'

  spec.files         = `git ls-files -z`.split("\x0")
                                        .reject do |f|
                                          f.match(%r{^(test|spec|features)/})
                                        end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'secure_headers'
  spec.add_dependency 'activesupport'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'actionpack'
end
