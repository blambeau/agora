require 'spec_helper'
module Agora
  describe Model, "minus" do

    let(:model){ minepump_model }

    subject{
      model - view
    }

    context 'when the view contains assignments' do
      let(:view){ model.select{|s|
        s.assignments = model.assignments
      } }

      it 'should be all but assignments' do
        subject.goals.should eq(model.goals)
        subject.assignments.should be_empty
      end
    end

  end
end
