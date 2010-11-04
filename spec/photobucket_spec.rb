require 'lib/muri.rb'

shared_examples_for "Photobucket parse" do
  it "should be Photobucket service" do
    #@a.media_service.should == 'Photobucket'
    @a.photobucket?.should == true
  end
  
  it "should be not be other services" do
    @a.vimeo?.should == false
    @a.youtube?.should == false
    @a.facebook?.should == false
    @a.flickr?.should == false
  end
    
  it "should be valid" do
    @a.valid?.should == true
  end
end

shared_examples_for "Photobucket parse photo" do
  it_should_behave_like "Photobucket parse"
  
  it "should have media api type = PHOTOBUCKET_MEDIA" do
    @a.media_api_type.should == Muri::PHOTOBUCKET_MEDIA
  end
  
  it "should be photobucket media" do
    @a.photobucket_media?.should == true
  end  
end

shared_examples_for "Photobucket parse album" do
  it_should_behave_like "Photobucket parse"
  
  it "should have media api type = PHOTOBUCKET_ALBUM" do
    @a.media_api_type.should == Muri::PHOTOBUCKET_ALBUM
  end

  it "should be photobucket album" do
    @a.photobucket_album?.should == true
  end 
  
#   it "should not be facebook album" do
#     @a.facebook_album?.should == false
#   end    
end
shared_examples_for "Photobucket parse group album" do
  it_should_behave_like "Photobucket parse"
  
  it "should have media api type = PHOTOBUCKET_GROUP_ALBUM" do
    @a.media_api_type.should == Muri::PHOTOBUCKET_GROUP_ALBUM
  end
  
  it "should be group album" do
    @a.photobucket_group_album?.should == true
  end  
end

{'http://gs0001.photobucket.com/groups/0001/F9P8EG7YR8/' =>
  { :type => :group_album,
    :media_id => 'F9P8EG7YR8',
    :media_api_id => 'F9P8EG7YR8',
    :media_website => 'http://gs0001.photobucket.com/groups/0001/F9P8EG7YR8/'
  },
  'http://s244.photobucket.com/albums/gg17/pbapi/api-test/api-test-subalbum/' =>
  { :type => :album,
    :media_id => 'pbapi/api-test/api-test-subalbum',
    :media_api_id => 'pbapi/api-test/api-test-subalbum',
    :media_website => 'http://s244.photobucket.com/albums/gg17/pbapi/api-test/api-test-subalbum/'
  },
  'http://i587.photobucket.com/albums/ss319/bananastalktome/API%20Testing/bananastalktomegmailcom_6c337a91.jpg' =>
  { :type => :photo,
    :media_id => 'bananastalktomegmailcom_6c337a91',
    :media_content_type => 'jpg',
    :media_url => "http://i587.photobucket.com/albums/ss319/bananastalktome/API%20Testing/bananastalktomegmailcom_6c337a91.jpg",
    :media_api_id => "http://i587.photobucket.com/albums/ss319/bananastalktome/API%20Testing/bananastalktomegmailcom_6c337a91.jpg" 
  },
  'http://i244.photobucket.com/albums/gg17/pbapi/file.jpg' =>
  { :type => :photo,
    :media_id => 'file',
    :media_content_type => 'jpg',
    :media_website => "http://s244.photobucket.com/albums/gg17/pbapi/?action=view&current=file.jpg",
    :media_url => "http://i244.photobucket.com/albums/gg17/pbapi/file.jpg",
    :media_api_id => "http://i244.photobucket.com/albums/gg17/pbapi/file.jpg",
    :media_thumbnail => 'http://mobth244.photobucket.com/albums/gg17/pbapi/file.jpg'
  },
  'http://gi0006.photobucket.com/groups/0006/G5PAK3TBQS/DSCF0015-1-1.jpg' =>
  { :type => :photo,
    :media_id => 'DSCF0015-1-1',
    :media_content_type => "jpg",
    :media_website => "http://gs0006.photobucket.com/groups/0006/G5PAK3TBQS/?action=view&current=DSCF0015-1-1.jpg",
    :media_url => "http://gi0006.photobucket.com/groups/0006/G5PAK3TBQS/DSCF0015-1-1.jpg",
    :media_thumbnail => 'http://mobth0006.photobucket.com/groups/0006/G5PAK3TBQS/DSCF0015-1-1.jpg',
    :media_api_id => "http://gi0006.photobucket.com/groups/0006/G5PAK3TBQS/DSCF0015-1-1.jpg"    
  },
  "http://i391.photobucket.com/albums/oo351/ariawei/h006.jpg" =>
  { :type => :photo,
    :media_api_id => 'http://i391.photobucket.com/albums/oo351/ariawei/h006.jpg'
  },
  "http://i163.photobucket.com/albums/t294/hollywoodaflame/Macro%20Photography/PhotoClass010.jpg" =>
  { :type => :photo,
    :media_api_id =>     'http://i163.photobucket.com/albums/t294/hollywoodaflame/Macro%20Photography/PhotoClass010.jpg'
  },
  "http://s391.photobucket.com/albums/oo351/ariawei/canon%20epoca135/?action=view&current=Negative0-08-081.jpg" =>
  { :type => :photo,
    :media_api_id => 'http://i391.photobucket.com/albums/oo351/ariawei/canon%20epoca135/Negative0-08-081.jpg'
  },
  "http://s391.photobucket.com/albums/oo351/ariawei/canon%20epoca135/" =>
  { :type => :album,
    :media_api_id => 'ariawei/canon%20epoca135'
  },
  "http://gs0001.photobucket.com/groups/0001/F9P8EG7YR8/?action=view&current=357krdd.jpg" =>
  { :type => :photo,
    :media_api_id => 'http://gi0001.photobucket.com/groups/0001/F9P8EG7YR8/357krdd.jpg'
  }
}.each do |url, values|
  
  describe "Photobucket parse #{values[:type]} #{url}" do
    before(:all) do
      @a = Muri.parse url
    end
    if values[:type] == :photo
      it_should_behave_like "Photobucket parse photo"
    elsif values[:type] == :album
      it_should_behave_like "Photobucket parse album"
    elsif values[:type] == :group_album
      it_should_behave_like "Photobucket parse group album"
    end
      
    if values[:media_id]
      it "should have media id" do
        @a.media_id.should == values[:media_id]
      end
    end
    
    if values[:media_content_type]
      it "should have content type" do
        @a.media_content_type.should ==values[:media_content_type]
      end
    end
    
    if values[:media_website]
      it "should have a website" do
        @a.media_website.should == values[:media_website]
      end
    end
    
    if values[:media_url]
      it "should have media url" do
        @a.media_url.should == values[:media_url]
      end
    end
    
    if values[:media_thumbnail]
      it "should have media thumbnail" do
        @a.media_thumbnail.should == values[:media_thumbnail]
      end
    end
    
    if values[:media_api_id]
      it "should have media api id" do
        @a.media_api_id.should == values[:media_api_id]
      end
    end
  end
end