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

    it 'provides setters as well as getters' do
      foo = Foo.new(age: "17")
      foo.age = 18
      foo.age.should eq(18)
    end

    it 'adds coercion on setters' do
      foo = Foo.new(age: "17")
      foo.age = "18"
      foo.age.should eq(18)
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

    it 'provides a dup helper' do
      foo  = Foo.new(age: "17")
      foo2 = foo.dup
      foo3 = foo.dup{|f| f.age = 18 }
      foo.age.should eq(17)
      foo2.age.should eq(17)
      foo3.age.should eq(18)
    end

  end
end
