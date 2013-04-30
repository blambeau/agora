require 'spec_helper'
module Agora
  describe Model, "selection" do

    let(:model){ Model.load(file) }
    let(:file){ Path.backfind("examples/minepump.json") }

    subject{
      model.selection{|m,s| s.agents = Relation::DUM }
    }

    it 'returns a Model' do
      subject.should be_a(Model)
    end

    it 'does not touch the original model' do
      subject
      model.agents.should_not be_empty
    end

    it 'restrict agents as expected' do
      subject.agents.should eq(Relation::DUM)
    end

    it 'keeps non overrided attributes unchanged' do
      subject.goals.should eq(model.goals)
    end

  end
end
