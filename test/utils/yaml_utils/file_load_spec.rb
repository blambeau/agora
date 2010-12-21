require File.expand_path('../../../spec_helper', __FILE__)
module Agora
  module YAMLUtils
    describe "file_load" do
      include YAMLUtils
    
      it "should merge as expected" do
        left  = File.expand_path('../fixtures/left.yaml', __FILE__)
        right = File.expand_path('../fixtures/right.yaml', __FILE__)
        expected = File.expand_path('../fixtures/merged.yaml', __FILE__)
        
        merged = file_load(left, {:recursive => true}) do |f,loaded,opts|
          docs = loaded["About"]["documents"] || []
          docs.collect{|extra|
            File.expand_path(File.join(File.dirname(f), extra))
          }
        end
        merged.should == YAML::load(File.read(expected))
      end
    
    end # describe "merge"
  end # module YAMLUtils
end # module Agora
