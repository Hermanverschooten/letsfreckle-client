# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'letsfreckle/client/version'

Gem::Specification.new do |spec|
  spec.name          = "letsfreckle-client"
  spec.version       = Letsfreckle::Client::VERSION
  spec.authors       = ["Herman verschooten"]
  spec.email         = ["Herman@verschooten.net"]
  spec.summary       = %q{Simple API consumer for letsfreckle.com}
  spec.description   = %q{I needed to access the new v2 api of letsfreckle.com, but could not find a gem to do this.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rspec"
end
