# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "igolf-client/version"

Gem::Specification.new do |gem|
  gem.authors       = ["Adam MacDonald"]
  gem.email         = ["adam@foursumgolf.com"]
  gem.description   = "iGolf Client Library"
  gem.summary       = "The iGolf client library allows users/members of iGolf to access iGolf's course, lists, GPS, vector and general reference data."
  gem.homepage      = "http://github.com/Foursum/igolf-client"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "igolf-client"
  gem.require_paths = ["lib"]
  gem.version       = IGolf::VERSION
  
  gem.add_dependency "rest-client"
end
