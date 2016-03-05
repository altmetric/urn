Gem::Specification.new do |s|
  s.name = 'urn'
  s.version = '0.1.2'
  s.authors = ['Ana Castro', 'Jonathan Hernandez']
  s.email = 'support@altmetric.com'
  s.summary = 'Utility methods to normalize and validate URNs'
  s.homepage = 'https://github.com/altmetric/urn'
  s.license = 'MIT'
  s.files = Dir['*.{md,txt}'] + Dir['lib/**/*.rb']
  s.test_files = Dir['spec/**/*.rb']

  s.add_development_dependency('rspec', '~> 3.4')
end
