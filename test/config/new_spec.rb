require File.expand_path('../../spec_helper', __FILE__)
module Agora
  describe "Config#initialize" do
    
    it "should support taking a string as argument" do
      lambda{ Config.new(".") }.should_not raise_error
    end
    
    it "should support taking a pathname as argument" do
      lambda{ Config.new(Pathname.new('.')) }.should_not raise_error
    end
    
  end 
end # module Agora
