require 'spec_helper'
module Agora
  class Model
    describe Helpers, "goals_parent_child" do

      let(:model){ fixture_model(:json) }

      subject{
        model.goals_parent_child.restrict(parent: "pumpon_when_highwater")[:parent, :child] 
      }

      let(:expected){
        Relation([
          {parent: "pumpon_when_highwater", child: "detected"},
          {parent: "pumpon_when_highwater", child: "on_when_detected"},
          {parent: "pumpon_when_highwater", child: "water_is_slow"}
        ])
      }

      it{ should eq(expected) }

    end
  end
end
