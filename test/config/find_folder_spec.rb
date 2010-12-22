require File.expand_path('../../spec_helper', __FILE__)
module Agora
  describe "Config#find_folder" do
    
    it "should correctly work on a folder with a .agora file" do
      Config.find_folder(Agora::FIXTURES_PATHNAME).should == Agora::FIXTURES_PATHNAME
    end
    
    it "should correctly work on an ancestor folder" do
      Config.find_folder(Agora::FIXTURES_PATHNAME + "subfolder").should == Agora::FIXTURES_PATHNAME
    end
    
    it "should raise an error when unable to find folder" do
      lambda { 
        Config.find_folder(Agora::FIXTURES_PATHNAME + "..") 
      }.should raise_error
    end
    
  end # Config#find_folder
end # module Agora