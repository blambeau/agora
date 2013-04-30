require 'spec_helper'
module Agora
  describe Typed do

    class Foo
      include Typed

      attribute :age, Integer
      attribute :hobbies, Relation[name: String]
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

    it 'sets a default value on relation-valued attributes' do
      foo = Foo.new(age: 12)
      foo.hobbies.should eq(Relation::DUM)
    end

  end
end
