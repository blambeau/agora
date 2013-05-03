require 'spec_helper'
module Agora
  describe "Kaos export" do

    context 'on the fixture model' do
      let(:model){ Agora::Model.load(fixtures/"model.json") }
      let(:expected){ (Path.dir/"expected.kaos").read }

      subject{ model.to_kaos }

      # before do
      #   puts subject
      # end

      it{ should eq(expected) }
    end

  end
end
