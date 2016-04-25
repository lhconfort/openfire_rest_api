# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openfire_rest_api/version'

Gem::Specification.new do |s|
  s.name          = "openfire_rest_api"
  s.version       = OpenfireRestApi::VERSION
  s.authors       = ["Matias Hick"]
  s.email         = ["unformatt@gmail.com"]
  s.description   = "Connect with openfire through rest api plugin"
  s.summary       = "Connect with openfire through rest api plugin"
  s.homepage      = "https://github.com/unformattmh/openfire_rest_api"
  s.license       = "MIT"

  s.files         = Dir["LICENSE.md", "README.md", "CHANGELOG.md", "CODE_OF_CONDUCT.md", "lib/**/*"]
  s.executables   = []
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", ">= 1.3"
  s.add_development_dependency "rake"

  s.add_runtime_dependency "rest-client", ">= 1.6.7"
end
