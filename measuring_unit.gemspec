$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "measuring_unit/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "measuring_unit"
  s.version     = MeasuringUnit::VERSION
  s.authors     = ["nrnickolov@yahoo.com"]
  s.email       = ["nrnickolov@yahoo.com"]
  s.homepage    = "https://github.com/nnikolov/measuring_unit"
  s.summary     = "Fractional inches and milimeters"
  s.description = "Description of MeasuringUnit."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.13"

  s.add_development_dependency "sqlite3"
end
