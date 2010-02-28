begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "muri"
    gem.summary = "Media URI Parser"
    gem.email = "bananastalktome@gmail.com"
    gem.homepage = "http://github.com/bananastalktome/muri/"
    gem.description = "Automatically get media information from the URL."
    gem.authors = ["William Schneider"]
    gem.files.exclude 'test.sqlite3'
    gem.has_rdoc = true
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
require 'rake'
require 'spec/rake/spectask'

Spec::Rake::SpecTask.new('tests') do |t|
  t.spec_files = FileList['test/*.rb']
end
