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

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'dry-matcher'
  spec.add_dependency 'dry-monads'
  spec.add_dependency 'duckface-interfaces'

  spec.add_development_dependency 'bundler', '>= 1.13'
  spec.add_development_dependency 'rake', '>= 10.0'
  spec.add_development_dependency 'rspec', '>= 3.0'
end
