Gem::Specification.new do |s|
  s.name        = 'cukehub'
  s.version     = '0.9.4.2'
  s.date        = '2017-03-08'
  s.summary     = "CukeHub!"
  s.description = "Store and Share your Cucumber Test Results at CukeHub."
  s.authors     = ["Rich Downie"]
  s.email       = 'rich@cukehub.com'
  s.files       = ["lib/cukehub.rb"]
  s.homepage    = 'http://cukehub.com'
  s.license     = 'MIT'
  s.add_dependency "httparty", '~> 0'
  s.add_dependency "os", '~> 0'
end
