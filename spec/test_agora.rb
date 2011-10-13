require File.expand_path('../spec_helper', __FILE__)
describe Agora do

  it "should have a version number" do
    Agora.const_defined?(:VERSION).should be_true
  end

end
