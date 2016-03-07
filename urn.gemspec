Gem::Specification.new do |spec|
  spec.name          = 'urn'
  spec.version       = '0.1.2'
  spec.authors       = ['Ana Castro', 'Jonathan Hernandez']
  spec.email         = 'support@altmetric.com'

  spec.summary       = 'Utility methods to normalize and validate URNs'
  spec.homepage      = 'https://github.com/altmetric/urn'
  spec.license       = 'MIT'

  spec.files         = Dir['*.{md,txt}', 'lib/**/*.rb']
  spec.test_files    = Dir['spec/**/*.rb']
  spec.bindir        = 'exe'

  spec.add_development_dependency('bundler', '~> 1.10')
  spec.add_development_dependency('rake', '~> 10.0')
  spec.add_development_dependency('rspec', '~> 3.4')
end
