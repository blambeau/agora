require 'spec_helper'
module Agora
  class Model
    describe Helpers, "goal_descendants" do

      let(:model){ fixture_model(:json) }

      subject{
        model.goal_descendants(model.goals.restrict(id: "pumpon_when_highwater"))
      }

      it 'shoud have expected resulting type' do
        pending{
          subject.class.should eq(model.goals.class)
        }
      end

      it 'should have expected ids' do
        expected = Relation([
          {id: "pumpon_when_highwater"},
          {id: "detected"},
          {id: "on_when_detected"},
          {id: "pumpon_automatically"},
          {id: "pumpon_manually"}
        ])
        subject[:id].should eq(expected)
      end

    end
  end
end
