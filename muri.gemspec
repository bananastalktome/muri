# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{muri}
  s.version = "1.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["William Schneider"]
  s.date = %q{2011-04-19}
  s.description = %q{Automatically get media information from the URL.}
  s.email = %q{bananastalktome@gmail.com}
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    ".gitignore",
     "CHANGELOG",
     "README.textile",
     "Rakefile",
     "VERSION.yml",
     "lib/muri.rb",
     "lib/muri/base.rb",
     "lib/muri/filter.rb",
     "lib/muri/filters/facebook.rb",
     "lib/muri/filters/flickr.rb",
     "lib/muri/filters/imageshack.rb",
     "lib/muri/filters/photobucket.rb",
     "lib/muri/filters/picasa.rb",
     "lib/muri/filters/twitpic.rb",
     "lib/muri/filters/vimeo.rb",
     "lib/muri/filters/youtube.rb",
     "muri.gemspec",
     "spec/error_spec.rb",
     "spec/facebook_spec.rb",
     "spec/flickr_spec.rb",
     "spec/imageshack_spec.rb",
     "spec/photobucket_spec.rb",
     "spec/picasa_spec.rb",
     "spec/twitpic_spec.rb",
     "spec/vimeo_spec.rb",
     "spec/youtube_spec.rb"
  ]
  s.homepage = %q{http://github.com/bananastalktome/muri/}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Media URI Parser}
  s.test_files = [
    "spec/vimeo_spec.rb",
     "spec/flickr_spec.rb",
     "spec/twitpic_spec.rb",
     "spec/picasa_spec.rb",
     "spec/photobucket_spec.rb",
     "spec/facebook_spec.rb",
     "spec/youtube_spec.rb",
     "spec/error_spec.rb",
     "spec/imageshack_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

