# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll/menu/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-menu"
  spec.version       = Jekyll::Menu::VERSION
  spec.authors       = ["ItsJonQ"]
  spec.email         = ["itsjonq@gmail.com"]

  spec.summary       = "Easy menu creation with YAML data"
  spec.homepage      = "https://github.com/helpscout/jekyll-menu"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("jekyll", "3.1.2")

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "minitest-profile"
  spec.add_development_dependency "minitest", "~> 5.8"
  spec.add_development_dependency "rspec-mocks"
  spec.add_development_dependency "shoulda"
  spec.add_development_dependency "kramdown"
end
