require 'spec_helper'
module Agora
  describe Model, "select" do

    let(:model){ minepump_model }

    subject{
      model.select{|s|
        s.goals = (model.goals =~ Relation(name: ["Maintain[PumpOn If High Water Detected]",
                                                  "Maintain[PumpOn IIf Pump Switch On]"]))
        s.assignments = (model.assignments =~ s.goals[goal: :id])
      }
    }

    let(:expected_goals){
      Relation(name: ["Maintain[PumpOn If High Water Detected]",
                      "Maintain[PumpOn IIf Pump Switch On]",
                      "Maintain[Pump Switch On If High Water Detected]"])
    }

    let(:expected_agents){
      Relation(name: ["SafetyController", "PumpActuator"])
    }

    it{ should be_a(Model) }

    it 'restrict goals as expected' do
      subject.goals[:name].should eq(expected_goals)
    end

    it 'restrict agents as expected' do
      subject.agents[:name].should eq(expected_agents)
    end

  end
end
