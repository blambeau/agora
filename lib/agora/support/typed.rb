module Agora
  module Typed

    def self.included(x)
      x.extend(ClassMethods)
    end

    def initialize(h)
      self.class.attributes.each_pair do |attrname,attrtype|
        value = h[attrname] || h[attrname.to_s]
        value = Relation::DUM if value.nil? and attrtype <= Alf::Relation
        value = if attrtype.respond_to?(:coerce)
                  attrtype.coerce(value)
                else
                  Alf::Support.coerce(value, attrtype)
                end
        instance_variable_set("@#{attrname}", value)
      end
    end

    def to_hash
      self.class.attributes.keys.each_with_object({}){|k,h|
        h[k] = instance_variable_get("@#{k}")
      }
    end

    def to_tuple
      Tuple[self.class.attributes].new(to_hash)
    end

    def to_relation
      Relation[self.class.attributes].new(Set.new << to_tuple)
    end

    def to_table
      Relation(to_hash.map{|k,v| {attribute: k, value: v} })
    end

    def to_s
      to_table.to_s
    end

    module ClassMethods

      def attributes
        @attributes ||= {}
      end

      def attribute(name, type)
        attributes[name] = type
        define_method(name){ instance_variable_get("@#{name}") }
      end
    end

  end # module Typed
end # module Agora
