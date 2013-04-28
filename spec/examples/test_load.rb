require 'spec_helper'
module Agora
  Helpers.examples.each do |ex|
    describe "Loading example #{ex.basename}" do

      subject{ Model.load(ex) }

      it 'should succeed' do
        lambda{
          subject
        }.should_not raise_error
      end

    end
  end
end