# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'muri/version.rb'

Gem::Specification.new do |s|
  s.name = %q{muri}
  s.version = Muri::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["William Schneider"]

  s.description = %q{Automatically get media information from the URL.}
  s.summary = %q{Media URI Parser}
  s.email = %q{bananastalktome@gmail.com}
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = `git ls-files`.split($/)
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
  s.homepage = %q{https://github.com/bananastalktome/muri/}
  s.rdoc_options = ["--charset=UTF-8"]
   
  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency "rake"
  s.add_development_dependency 'rspec'

end

