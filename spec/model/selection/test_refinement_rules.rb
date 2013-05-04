require 'spec_helper'
module Agora
  class Model
    describe Selection, "refinement rules" do

      let(:model){ minepump_model }

      subject{
        selection.to_model
      }

      describe "adding refinements directly" do
        let(:selection){
          Selection.new(model){|sel| sel.goal_refinements = model.goal_refinements }
        }

        it 'should end-up with all goals' do
          subject.goals.should eq(model.goals)
        end

        it 'should end-up with all domain descriptions' do
          #subject.domain_properties.should eq(model.domain_properties)
          subject.domain_hypotheses.should eq(model.domain_hypotheses)
        end
      end

      describe "adding refinements through parent/child relationships" do
        let(:selection){
          Selection.new(model){|sel|
            sel.goals = (model.goals =~ Relation(id: ["pumpon_when_highwater", "highwater_detected"]))
          }
        }

        it 'should end-up with the refinement' do
          subject.goal_refinements.size.should eq(1)
        end

        it 'should end-up with three goals' do
          subject.goals.size.should eq(3)
        end
      end

    end
  end
end
