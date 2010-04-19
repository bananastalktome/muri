begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "muri"
    gem.summary = "Media URI Parser"
    gem.email = "bananastalktome@gmail.com"
    gem.homepage = "http://github.com/bananastalktome/muri/"
    gem.description = "Automatically get media information from the URL."
    gem.authors = ["William Schneider"]
    #gem.add_dependency("nokogiri")
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

task :markup do
  require 'RedCloth'
  textile = File.open("#{File.dirname(__FILE__)}/README.textile")
  output = RedCloth.new(textile.read).to_html
  file = "#{File.dirname(__FILE__)}/README.html"
  if File.exists?(file)
    File.delete file
  end
  final = github_markup_text(output)
  File.open(file, "w") { |f| f.write(final) }
end

def github_markup_text(output); GITHUB_STYLE_WRAP+output+"</div></html>" end

GITHUB_STYLE_WRAP = <<-eos
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html id="readme">
<style type="text/css">
#readme {
font:13.34px helvetica,arial,freesans,clean,sans-serif;
}
#readme.announce {
margin:1em 0;
}
#readme span.name {
font-size:140%;
padding:0.8em 0;
}
#readme div.plain, #readme div.wikistyle {
background-color:#F8F8F8;
padding:0.7em;
}
#readme.announce div.plain, #readme.announce div.wikistyle {
border:1px solid #E9E9E9;
}
#readme.blob div.plain, #readme.blob div.wikistyle {
border-top:medium none;
}
#readme div.plain pre {
color:#444444;
font-family:'Bitstream Vera Sans Mono','Courier',monospace;
font-size:85%;
}
#missing-readme {
background-color:#FFFFCC;
border:1px solid #CCCCCC;
font:13.34px helvetica,arial,freesans,clean,sans-serif;
padding:0.7em;
text-align:center;
}
#readme.rst .borderless, #readme.rst table.borderless td, #readme.rst table.borderless th {
border:0 none;
}
#readme.rst table.borderless td, #readme.rst table.borderless th {
padding:0 0.5em 0 0 !important;
}
#readme.rst .first {
margin-top:0 !important;
}
#readme.rst .last, #readme.rst .with-subtitle {
margin-bottom:0 !important;
}
#readme.rst .hidden {
display:none;
}
#readme.rst a.toc-backref {
color:black;
text-decoration:none;
}
#readme.rst blockquote.epigraph {
margin:2em 5em;
}
#readme.rst dl.docutils dd {
margin-bottom:0.5em;
}
#readme.rst div.abstract {
margin:2em 5em;
}
#readme.rst div.abstract p.topic-title {
font-weight:bold;
text-align:center;
}
#readme.rst div.admonition, #readme.rst div.attention, #readme.rst div.caution, #readme.rst div.danger, #readme.rst div.error, #readme.rst div.hint, #readme.rst div.important, #readme.rst div.note, #readme.rst div.tip, #readme.rst div.warning {
border:medium outset;
margin:2em;
padding:1em;
}
#readme.rst div.admonition p.admonition-title, #readme.rst div.hint p.admonition-title, #readme.rst div.important p.admonition-title, #readme.rst div.note p.admonition-title, #readme.rst div.tip p.admonition-title {
font-family:sans-serif;
font-weight:bold;
}
#readme.rst div.attention p.admonition-title, #readme.rst div.caution p.admonition-title, #readme.rst div.danger p.admonition-title, #readme.rst div.error p.admonition-title, #readme.rst div.warning p.admonition-title {
color:red;
font-family:sans-serif;
font-weight:bold;
}
#readme.rst div.dedication {
font-style:italic;
margin:2em 5em;
text-align:center;
}
#readme.rst div.dedication p.topic-title {
font-style:normal;
font-weight:bold;
}
#readme.rst div.figure {
margin-left:2em;
margin-right:2em;
}
#readme.rst div.footer, #readme.rst div.header {
clear:both;
font-size:smaller;
}
#readme.rst div.line-block {
display:block;
margin-bottom:1em;
margin-top:1em;
}
#readme.rst div.line-block div.line-block {
margin-bottom:0;
margin-left:1.5em;
margin-top:0;
}
#readme.rst div.sidebar {
background-color:#FFFFEE;
border:medium outset;
clear:right;
float:right;
margin:0 0 0.5em 1em;
padding:1em;
width:40%;
}
#readme.rst div.sidebar p.rubric {
font-family:sans-serif;
font-size:medium;
}
#readme.rst div.system-messages {
margin:5em;
}
#readme.rst div.system-messages h1 {
color:red;
}
#readme.rst div.system-message {
border:medium outset;
padding:1em;
}
#readme.rst div.system-message p.system-message-title {
color:red;
font-weight:bold;
}
#readme.rst div.topic {
margin:2em;
}
#readme.rst h1.section-subtitle, #readme.rst h2.section-subtitle, #readme.rst h3.section-subtitle, #readme.rst h4.section-subtitle, #readme.rst h5.section-subtitle, #readme.rst h6.section-subtitle {
margin-top:0.4em;
}
#readme.rst h1.title {
text-align:center;
}
#readme.rst h2.subtitle {
text-align:center;
}
#readme.rst hr.docutils {
width:75%;
}
#readme.rst img.align-left, #readme.rst .figure.align-left, #readme.rst object.align-left {
clear:left;
float:left;
margin-right:1em;
}
#readme.rst img.align-right, #readme.rst .figure.align-right, #readme.rst object.align-right {
clear:right;
float:right;
margin-left:1em;
}
#readme.rst img.align-center, #readme.rst .figure.align-center, #readme.rst object.align-center {
display:block;
margin-left:auto;
margin-right:auto;
}
#readme.rst .align-left {
text-align:left;
}
#readme.rst .align-center {
clear:both;
text-align:center;
}
#readme.rst .align-right {
text-align:right;
}
#readme.rst div.align-right {
text-align:left;
}
#readme.rst ol.simple, #readme.rst ul.simple {
margin-bottom:1em;
}
#readme.rst ol.arabic {
list-style:decimal outside none;
}
#readme.rst ol.loweralpha {
list-style:lower-alpha outside none;
}
#readme.rst ol.upperalpha {
list-style:upper-alpha outside none;
}
#readme.rst ol.lowerroman {
list-style:lower-roman outside none;
}
#readme.rst ol.upperroman {
list-style:upper-roman outside none;
}
#readme.rst p.attribution {
margin-left:50%;
text-align:right;
}
#readme.rst p.caption {
font-style:italic;
}
#readme.rst p.credits {
font-size:smaller;
font-style:italic;
}
#readme.rst p.label {
white-space:nowrap;
}
#readme.rst p.rubric {
color:maroon;
font-size:larger;
font-weight:bold;
text-align:center;
}
#readme.rst p.sidebar-title {
font-family:sans-serif;
font-size:larger;
font-weight:bold;
}
#readme.rst p.sidebar-subtitle {
font-family:sans-serif;
font-weight:bold;
}
#readme.rst p.topic-title {
font-weight:bold;
}
#readme.rst pre.address {
font:inherit;
margin-bottom:0;
margin-top:0;
}
#readme.rst pre.literal-block, #readme.rst pre.doctest-block {
margin-left:2em;
margin-right:2em;
}
#readme.rst span.classifier {
font-family:sans-serif;
font-style:oblique;
}
#readme.rst span.classifier-delimiter {
font-family:sans-serif;
font-weight:bold;
}
#readme.rst span.interpreted {
font-family:sans-serif;
}
#readme.rst span.option {
white-space:nowrap;
}
#readme.rst span.pre {
white-space:pre;
}
#readme.rst span.problematic {
color:red;
}
#readme.rst span.section-subtitle {
font-size:80%;
}
#readme.rst table.citation {
border-left:1px solid gray;
margin-left:1px;
}
#readme.rst table.docinfo {
margin:2em 4em;
}
#readme.rst table.docutils {
margin-bottom:0.5em;
margin-top:0.5em;
}
#readme.rst table.footnote {
border-left:1px solid black;
margin-left:1px;
}
#readme.rst table.docutils td, #readme.rst table.docutils th, #readme.rst table.docinfo td, #readme.rst table.docinfo th {
padding-left:0.5em;
padding-right:0.5em;
vertical-align:top;
}
#readme.rst table.docutils th.field-name, #readme.rst table.docinfo th.docinfo-name {
font-weight:bold;
padding-left:0;
text-align:left;
white-space:nowrap;
}
#readme.rst h1 tt.docutils, #readme.rst h2 tt.docutils, #readme.rst h3 tt.docutils, #readme.rst h4 tt.docutils, #readme.rst h5 tt.docutils, #readme.rst h6 tt.docutils {
font-size:100%;
}
#readme.rst ul.auto-toc {
list-style-type:none;
}
.wikistyle h1, .wikistyle h2, .wikistyle h3, .wikistyle h4, .wikistyle h5, .wikistyle h6 {
border:0 none !important;
}
.wikistyle h1 {
border-top:4px solid #AAAAAA !important;
font-size:170% !important;
margin-top:1.5em !important;
padding-top:0.5em !important;
}
.wikistyle h1:first-child {
border-top:medium none !important;
margin-top:0 !important;
padding-top:0.25em !important;
}
.wikistyle h2 {
border-top:4px solid #E0E0E0 !important;
font-size:150% !important;
margin-top:1.5em !important;
padding-top:0.5em !important;
}
.wikistyle h3 {
margin-top:1em !important;
}
.wikistyle p {
line-height:1.5em !important;
margin:1em 0 !important;
}
.wikistyle ul {
margin:1em 0 1em 2em !important;
}
.wikistyle ol {
margin:1em 0 1em 2em !important;
}
.wikistyle ul ul, .wikistyle ul ol, .wikistyle ol ol, .wikistyle ol ul {
margin-bottom:0 !important;
margin-top:0 !important;
}
.wikistyle blockquote {
border-left:5px solid #DDDDDD !important;
color:#555555 !important;
margin:1em 0 !important;
padding-left:0.6em !important;
}
.wikistyle dt {
font-weight:bold !important;
margin-left:1em !important;
}
.wikistyle dd {
margin-bottom:1em !important;
margin-left:2em !important;
}
.wikistyle table {
margin:1em 0 !important;
}
.wikistyle table th {
border-bottom:1px solid #BBBBBB !important;
padding:0.2em 1em !important;
}
.wikistyle table td {
border-bottom:1px solid #DDDDDD !important;
padding:0.2em 1em !important;
}
.wikistyle pre {
background-color:#F8F8FF !important;
border:1px solid #DEDEDE !important;
color:#444444 !important;
font-size:90% !important;
line-height:1.5em !important;
margin:1em 0 !important;
overflow:auto !important;
padding:0.5em !important;
}
.wikistyle pre code {
background-color:#F8F8FF !important;
border:medium none !important;
font-size:100% !important;
padding:0 !important;
}
.wikistyle code {
background-color:#F8F8FF !important;
border:1px solid #DEDEDE !important;
color:#444444 !important;
font-size:90% !important;
padding:0 0.2em !important;
}
.wikistyle pre.console {
background-color:black !important;
color:white !important;
font-size:90% !important;
line-height:1.5em !important;
margin:1em 0 !important;
padding:0.5em !important;
}
.wikistyle pre.console code {
background-color:black !important;
border:medium none !important;
color:white !important;
font-size:100% !important;
padding:0 !important;
}
.wikistyle pre.console span {
color:#888888 !important;
}
.wikistyle pre.console span.command {
color:yellow !important;
}
</style>
<div class="wikistyle">
eos