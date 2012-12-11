require File.expand_path('../../../spec_helper', __FILE__)
module Agora
  module YAMLUtils
    describe "file_load" do
      include YAMLUtils
    
      it "should merge as expected" do
        left  = Path.dir/'fixtures/left.yaml'
        right = Path.dir/'fixtures/right.yaml'
        expected = Path.dir/'fixtures/merged.yaml'
        
        merged = file_load(left, {:recursive => true}) do |f,loaded,opts|
          docs = loaded["About"]["documents"] || []
          docs.map{|extra| f.dir/extra }
        end
        merged.should == YAML::load(expected.read)
      end
    
    end # describe "merge"
  end # module YAMLUtils
end # module Agora
