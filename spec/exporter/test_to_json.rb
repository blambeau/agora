require 'spec_helper'
module Agora
  describe "Json export" do

    context 'on the minepump' do
      let(:model){ minepump_model }

      subject{ model.to_json }

      it{ should be_a(String) }
    end

  end
end
