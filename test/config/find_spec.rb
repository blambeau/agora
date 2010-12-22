require File.expand_path('../../spec_helper', __FILE__)
module Agora
  
  FIXTURES_PATHNAME = Pathname.new('../../fixtures').expand_path(__FILE__)
  
  describe "Config#find" do
    
    it "should correctly work on a folder with a .agora file" do
      cfg = Config.find(Agora::FIXTURES_PATHNAME)
      cfg.root_folder.should == Agora::FIXTURES_PATHNAME
    end
    
    it "should correctly work on an ancestor folder" do
      cfg = Config.find(Agora::FIXTURES_PATHNAME + "subfolder")
      cfg.root_folder.should == Agora::FIXTURES_PATHNAME
    end
    
    it "should raise an error when unable to find folder" do
      lambda { 
        Config.find(Agora::FIXTURES_PATHNAME + "..") 
      }.should raise_error
    end
    
  end 
end # module Agora