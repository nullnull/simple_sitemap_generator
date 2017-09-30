# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_sitemap_generator'

Gem::Specification.new do |spec|
  spec.name          = 'simple_sitemap_generator'
  spec.version       = SimpleSitemapGenerator::VERSION
  spec.authors       = ['Katsuma Narisawa']
  spec.email         = ['face.the.music721@gmail.com']

  spec.summary       = 'Generates sitemap.xml automatically by using config/routes.rb'
  spec.homepage      = 'https://github.com/nullnull/simple_sitemap_generator'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
