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

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    #spec.metadata['allowed_push_host'] = "https://gems.weblinc.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

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
