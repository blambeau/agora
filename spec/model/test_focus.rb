require 'spec_helper'
module Agora
  describe Model, "focus" do

    let(:model){ Model.load(file) }

    subject{ model.focus(selection) }

    context 'on the minepump' do
      let(:file){ Path.backfind("examples/minepump.json") }

      let(:selection){
        model.selection{|m,s|
          s.goals = (m.goals =~ Relation(name: ["Maintain[PumpOn If High Water Detected]",
                                                "Maintain[PumpOn IIf Pump Switch On]"]))
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

      pending{
        it 'restrict goals as expected' do
          subject.goals[:name].should eq(expected_goals)
        end

        it 'restrict agents as expected' do
          subject.agents[:name].should eq(expected_agents)
        end
      }
    end

  end
end
