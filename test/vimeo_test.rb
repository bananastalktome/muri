require 'lib/muri.rb'

shared_examples_for "Vimeo parse" do
  it "should be Vimeo service" do
    @a.service == 'Vimeo'
  end
  
  it "should have media id" do
    @a.media_id == '7312128'
  end
  
  it "should have media url" do
    @a.media_url == 'http://vimeo.com/7312128'
  end
   
  it "should have media api id" do
    @a.media_api_id == '7312128'
  end
end
describe "Vimeo parse first" do
  before (:all) do
    @a = Muri.parse 'http://vimeo.com/moogaloop.swf?clip_id=7312128&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1'
  end
  it_should_behave_like "Vimeo parse"
end
describe "Vimeo parse second" do
  before (:all) do
    @a = Muri.parse 'http://vimeo.com/7312128'
  end
  it_should_behave_like "Vimeo parse"
end