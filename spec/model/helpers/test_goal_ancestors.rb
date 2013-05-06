require 'spec_helper'
module Agora
  class Model
    describe Helpers, "goal_ancestors" do

      let(:model){ fixture_model }

      subject{
        model.goal_ancestors(model.goals.restrict(id: "pumpon_automatically"))
      }

      it 'shoud have expected resulting type' do
        pending{
          subject.class.should eq(model.goals.class)
        }
      end

      it 'should have expected ids' do
        expected = Relation([
          {id: "pumpon_automatically"},
          {id: "on_when_detected"},
          {id: "pumpon_when_highwater"}
        ])
        subject[:id].should eq(expected)
      end

    end
  end
end
