Gem::Specification.new do |s|
  s.name        = 'cukehub'
  s.version     = '1.0.0'
  s.date        = '2017-10-28'
  s.summary     = "CukeHub!"
  s.description = "The Fourth Amigo"
  s.authors     = ["Rich Downie"]
  s.email       = 'rich@cukehub.com'
  s.files       = ["lib/cukehub.rb"]
  s.homepage    = 'http://cukehub.com'
  s.license     = 'MIT'
  s.add_dependency "httparty", '~> 0'
  s.add_dependency "os", '~> 0'
end
