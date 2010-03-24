require 'lib/muri.rb'

#describe "Basic parse tests" do
#  @parsable = {"http://www.youtube.com/watch?v=IPFnWoYy_8w&feature=topvideos" => 'IPFnWoYy_8w',
#              "http://i391.photobucket.com/albums/oo351/ariawei/h006.jpg" => 'http://i391.photobucket.com/albums/oo351/ariawei/h006.jpg',
#              "http://i163.photobucket.com/albums/t294/hollywoodaflame/Macro%20Photography/PhotoClass010.jpg" => 'http://i163.photobucket.com/albums/t294/hollywoodaflame/Macro%20Photography/PhotoClass010.jpg'}
#  
#  @parsable.each do |a,b|
#    before(:all) do
#      @m = Muri.parse a
#    end
#    it "#{a} should be valid" do
#      #m = Muri.parse a
#      @m.valid?.should == true
#    end
#    
#    it "should have media_api_id" do
#      @m.media_api_id.should == b
#    end
#  end
#  
#end
  @parsable = {"http://www.youtube.com/watch?v=IPFnWoYy_8w&feature=topvideos" =>
                  'IPFnWoYy_8w',
              "http://i391.photobucket.com/albums/oo351/ariawei/h006.jpg" =>
                  'http://i391.photobucket.com/albums/oo351/ariawei/h006.jpg',
              "http://i163.photobucket.com/albums/t294/hollywoodaflame/Macro%20Photography/PhotoClass010.jpg" =>
                  'http://i163.photobucket.com/albums/t294/hollywoodaflame/Macro%20Photography/PhotoClass010.jpg',
              "http://s391.photobucket.com/albums/oo351/ariawei/canon%20epoca135/?action=view&current=Negative0-08-081.jpg" =>
                  'http://i391.photobucket.com/albums/oo351/ariawei/canon%20epoca135/Negative0-08-081.jpg',
              "http://s391.photobucket.com/albums/oo351/ariawei/canon%20epoca135/" =>
                  'ariawei/canon%20epoca135',
              "http://gs0001.photobucket.com/groups/0001/F9P8EG7YR8/?action=view&current=357krdd.jpg" =>
                  'http://gi0001.photobucket.com/groups/0001/F9P8EG7YR8/357krdd.jpg'}
  
@parsable.each do |a,b|
  describe "Basic parse tests #{a}" do
    before(:all) do
      @m = Muri.parse a
    end
    it "#{a} should be valid" do
      #m = Muri.parse a
      @m.valid?.should == true
    end
    
    it "should have media_api_id" do
      @m.media_api_id.should == b
    end
  end
  
end