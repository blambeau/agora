require 'spec_helper'
module Agora
  describe Model, ".load" do

    subject{ Model.load(fixtures/"model.json") }

    it 'load a model istance' do
      subject.should be_a(Model)
    end

    it 'loads agents correctly' do
      subject.agents.should be_a(Relation)
      subject.agents.size.should eq(1)
    end

  end
end