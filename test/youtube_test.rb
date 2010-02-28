require 'lib/muri.rb'

shared_examples_for "Youtube parse" do
it "should be youtube service" do
    @a.service == 'Youtube'
  end
  
  it "should have proper media id" do
    @a.media_id == '4CYDFoEz8rg'
  end
  
  it "should have proper media url" do
    @a.media_url == 'http://www.youtube.com/watch?v=4CYDFoEz8rg'
  end
  
  it "should have proper url" do
    @a.url == 'http://www.youtube.com/v/4CYDFoEz8rg'
  end
end

describe "Youtube parse first" do
  before (:all) do
    @a = Muri.parse "http://www.youtube.com/v/4CYDFoEz8rg&hl=en_US&fs=1&"
  end
  it_should_behave_like "Youtube parse"
end
describe "Youtube parse second" do
  before (:all) do
    @a = Muri.parse "http://www.youtube.com/watch?v=4CYDFoEz8rg"
  end
  it_should_behave_like "Youtube parse"
end