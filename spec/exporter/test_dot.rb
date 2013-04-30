require 'spec_helper'
module Agora
  describe "Graphviz dot export" do

    context 'on the minepump' do
      let(:model){ minepump_model }

      subject{ model.to_dot }

      it{ should be_a(String) }
    end

  end
end
