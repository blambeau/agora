require 'spec_helper'
module Agora
  describe Typed do

    class Foo
      include Typed

      attribute :age, Integer
    end

    it 'coerces correctly at construction' do
      foo = Foo.new(age: "17")
      foo.age.should eq(17)
    end

    it 'ignores extra' do
      lambda{
        Foo.new(age: "17", notsupported: "bla")
      }.should_not raise_error
    end

  end
end
