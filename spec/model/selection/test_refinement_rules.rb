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

    end
  end
end
