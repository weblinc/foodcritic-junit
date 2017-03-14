# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'foodcritic/junit/version'

Gem::Specification.new do |spec|
  spec.name          = "foodcritic-junit"
  spec.version       = Foodcritic::Junit::VERSION
  spec.authors       = ["Thomas Vendetta"]
  spec.email         = ["tvendetta@weblinc.com"]

  spec.summary       = %q{Converts FoodCritic output to JUnit XML}
  spec.description   = %q{Converts FoodCritic output to JUnit XML}
  spec.homepage      = 'http://weblinc.com'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "bin"
  spec.executables   = %w(foodcritic-junit)
  spec.require_paths = %w(lib)

  spec.add_dependency 'foodcritic','>= 9.0.0'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
