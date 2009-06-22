Gem::Specification.new do |s|
  s.name = "maplight"
  s.version = "0.0.0"
  s.date = "2009-06-19"
  s.summary = "Library for accessing the Maplight API."
  s.description = "Library for accessing the Maplight API. 
  Inspired by Luigi Montanez's SunLight gem and my _civic_ interests."
  s.rubyforge_project = ""
  s.email = "maplight.gem@gmail.com"
  s.homepage = "http://github.com/sinclair/maplight"
  s.authors = ["Sinclair Bain"]
  s.files = ['maplight.gemspec', 'lib/maplight.rb', 'lib/maplight/maplight_gateway.rb',
             'lib/maplight/maplight_organization.rb','README']
  s.add_dependency("json", [">= 1.1.3"])
  s.add_dependency("rest-client", [">= 0.8.2"])
  s.has_rdoc = true
end