module Agora
  module Typed

    def self.included(x)
      x.extend(ClassMethods)
    end

    def initialize(h)
      h.each_pair do |k,v|
        next unless type = self.class.attributes[k.to_sym]
        value = type.respond_to?(:coerce) ? type.coerce(v) : Alf::Support.coerce(v, type)
        instance_variable_set("@#{k}", value)
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
