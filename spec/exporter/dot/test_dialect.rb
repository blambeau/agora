require 'spec_helper'
module Agora
  module Exporter
    class Dot
      describe Dialect do

        it 'encodes node and edges ids as expected' do
          Dialect.render("${id}", id: "bla-\"bla").should eq('"bla-\"bla"')
        end

        it 'encodes hases as expected' do
          expected = %Q{label = "bla", size = "10"}
          Dialect.render("${attrs}", attrs: {label: "bla", size: 10}).should eq(expected)
        end

      end
    end
  end
end
