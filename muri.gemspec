# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{muri}
  s.version = "0.0.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["William Schneider"]
  s.date = %q{2010-03-09}
  s.description = %q{Automatically get media information from the URL.}
  s.email = %q{bananastalktome@gmail.com}
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    ".gitignore",
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
     "lib/muri/filters/twitpic.rb",
     "lib/muri/filters/vimeo.rb",
     "lib/muri/filters/youtube.rb",
     "muri.gemspec",
     "test/error_test.rb",
     "test/facebook_test.rb",
     "test/flickr_test.rb",
     "test/imageshack_test.rb",
     "test/photobucket_test.rb",
     "test/twitpic_test.rb",
     "test/vimeo_test.rb",
     "test/youtube_test.rb"
  ]
  s.homepage = %q{http://github.com/bananastalktome/muri/}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Media URI Parser}
  s.test_files = [
    "test/facebook_test.rb",
     "test/twitpic_test.rb",
     "test/photobucket_test.rb",
     "test/vimeo_test.rb",
     "test/imageshack_test.rb",
     "test/error_test.rb",
     "test/flickr_test.rb",
     "test/youtube_test.rb"
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

