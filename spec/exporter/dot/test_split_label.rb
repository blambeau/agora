require 'spec_helper'
module Agora
  module Exporter
    class Dot
      describe Helpers, "split_label" do
        include Helpers

        it "does not split a single word" do
          split_label("HelloWorld").should eq("HelloWorld")
        end

        it "splits as expected at given max" do
          split_label("Hello World, How Are You", 12).should eq('Hello World,\nHow Are You')
        end

      end
    end
  end
end