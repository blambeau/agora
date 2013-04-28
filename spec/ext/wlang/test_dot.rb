require 'spec_helper'
describe WLang::Dot do

  it 'encodes node and edges ids as expected' do
    WLang::Dot.render("${id}", id: "bla-\"bla").should eq('"bla-\"bla"')
  end

end