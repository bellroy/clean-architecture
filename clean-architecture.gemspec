# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clean_architecture/version'

Gem::Specification.new do |spec|
  spec.name          = 'clean-architecture'
  spec.version       = CleanArchitecture::VERSION
  spec.authors       = ['Bellroy Tech Team']
  spec.email         = ['tech@bellroy.com']

  spec.summary       = 'Bellroy Clean Architecture Framework'
  spec.description   = 'An attempt at building a reusable Clean Architecture framework for Ruby'
  spec.homepage      = 'https://bellroy.com'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'activemodel', '>= 5'
  spec.add_dependency 'activesupport', '>= 5'
  spec.add_dependency 'dry-matcher'
  spec.add_dependency 'dry-monads'
  spec.add_dependency 'dry-struct'
  spec.add_dependency 'dry-types'
  spec.add_dependency 'dry-validation', '>= 1.0.0'
  spec.add_dependency 'duckface-interfaces', '~> 0.0'
  spec.add_dependency 'sorbet-runtime'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
