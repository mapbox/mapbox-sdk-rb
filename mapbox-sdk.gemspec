$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

spec = Gem::Specification.new do |s|
  s.name = 'mapbox-sdk'
  s.version = '2.0.0'
  s.summary = 'Ruby bindings for the Mapbox API'
  s.description = ''
  s.authors = ['Tom MacWright']
  s.email = ['tom@mapbox.org']
  s.homepage = 'https://mapbox.com/developers'
  s.license = 'MIT'

  s.add_dependency('rest-client', '~> 2.0')

  s.add_development_dependency('mocha', '~> 0.13.2')
  s.add_development_dependency('shoulda', '~> 3.4.0')
  s.add_development_dependency('test-unit')
  s.add_development_dependency('rake')

  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
