require File.expand_path('../../../spec_helper', __FILE__)
module Agora
  module YAMLUtils
    describe "merge" do
      include YAMLUtils
    
      it "should return left atomic value if equal to right" do
        merge(12, 12).should == 12
      end
      
      it "should merge arrays" do
        merge([12], [14]).should == [12, 14]
      end
      
      it "should merge arrays as sets, not arrays" do
        merge([12, 14], [14]).should == [12, 14]
      end
      
      it "should merge simple hashes" do
        merge({:hello => "world"}, 
              {:who   => "agora"}).should == {
          :hello => "world",  :who => "agora"
        }
      end
      
      it "should merge hashes recursively" do
        left = {:hello => "world", :who => ["world"]}
        right = {:who => ["yaml"]}
        merge(left, right).should == {:hello => "world", :who => ["world", "yaml"]}
      end
    
    end # describe "merge"
  end # module YAMLUtils
end # module Agora
