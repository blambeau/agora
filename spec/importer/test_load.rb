require 'spec_helper'
module Agora
  describe Model, ".load" do

    shared_examples_for "the fixture model" do

      it 'is a model istance' do
        subject.should be_a(Model)
      end

      it 'has expected agents' do
        subject.agents.should be_a(Relation)
        subject.agents.size.should eq(1)
      end

      it 'has expected refinements' do
        subject.refinements.should be_a(Relation)
      end
    end

    subject{ Model.load(file) }

    context 'on a .json file' do
      let(:file){ fixtures/"model.json" }

      it_should_behave_like "the fixture model"
    end

    context 'on a .kaos file' do
      let(:file){ fixtures/"model.kaos" }

      it_should_behave_like "the fixture model"
    end

  end
end
