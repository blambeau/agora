require 'spec_helper'
module Agora
  describe Importer, "format_from_ext" do

    subject{ Importer.format_from_ext(Path.dir/"hello.kaos") }

    it{ should eq(:kaos) }

  end
end
