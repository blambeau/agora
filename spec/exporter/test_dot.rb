require 'spec_helper'
module Agora
  describe "Graphviz dot export" do

    subject{ model.to_dot }

    context 'on the minepump' do
      let(:model){ minepump_model }

      it{ should be_a(String) }
    end

    context 'on a single goal' do
      MODEL = <<-EOF
      declare goal
        id switch_pump_on
        name "Maintain [Pump Switch On If High Water Detected]"
        definition "When the high water level is detected, the pump switch is on"
        assignedto controller
      end
      EOF

      let(:path){ Path.tmpfile.tap{|f| f.write(MODEL) } }
      let(:model){ Model.load(path, :kaos) }

      it{ should be_a(String) }
    end

  end
end
