require 'spec_helper'
module Agora
  describe Model, "plus" do

    let(:model){ minepump_model }

    subject{
      left + right
    }

    context 'when the view contains assignments' do
      let(:left){ model.select{|s|
        s.goals = model.goals
      } }
      let(:right){ model.select{|s|
        s.assignments = model.assignments
      } }

      it 'should have all goals and all agents' do
        subject.goals.should eq(model.goals)
        subject.agents.should eq(model.agents)
      end
    end

  end
end
