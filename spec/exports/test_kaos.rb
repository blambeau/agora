require 'spec_helper'
module Agora
  describe "Kaos export" do

    context 'on the minepump' do
      let(:model){ minepump_model }

      subject{ model.to_kaos }

      it{ should be_a(String) }
    end

  end
end
