require 'spec_helper'
module Agora
  class Model
    describe Selection, "assignment rules" do

      let(:model){ minepump_model }

      subject{
        selection.to_model
      }

      describe "adding of goals and agents from assignments" do
        let(:selection){
          Selection.new(model){|sel| sel.assignments = model.assignments }
        }

        it 'should end-up with all agents' do
          subject.agents.should eq(model.agents)
        end

        it 'should end-up with all assigned goals' do
          subject.goals.should eq(model.goals =~ model.assignments[id: :goal])
        end

        it 'should not have anything else' do
          subject.domain_hypotheses.should be_empty
          subject.domain_properties.should be_empty
        end
      end

      describe "adding of assignments from goal and agent" do
        let(:selection){
          Selection.new(model){|sel|
            sel.agents = model.agents.restrict(id: "controller")
            sel.goals  = model.goals.restrict(id: "switch_pump_on")
          }
        }

        it 'has the corresponding assignment' do
          subject.assignments.size.should eq(1)
        end
      end
      
    end
  end
end
