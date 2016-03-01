# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'urn/version'

Gem::Specification.new do |spec|
  spec.name          = 'urn'
  spec.version       = Urn::VERSION
  spec.authors       = ['Ana Castro', 'Jonathan Hernandez']
  spec.email         = ['support@altmetric.com']

  spec.summary       = 'Utility methods to normalize and validate URNs'
  spec.description   = ''
  spec.homepage      = 'http://github.com/altmetric/urn'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end
