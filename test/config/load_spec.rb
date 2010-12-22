require File.expand_path('../../spec_helper', __FILE__)
module Agora
  describe "Config#load" do
    
    it "should correctly evaluate the config code" do
      cfg = Config.load(Agora::FIXTURES_PATHNAME)
      cfg.root_folder.should == Agora::FIXTURES_PATHNAME
      cfg.instance_eval{ @hello }.should == "world"
    end
    
  end # Config#load
end # module Agora