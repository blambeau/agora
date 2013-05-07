module Agora
  class Model
    module Operators

      def select
        Selection.new(self, &Proc.new).to_model
      end

      def -(other)
        select{|s|
          Model.attributes.each_pair do |name,_|
            s.send("#{name}=", self.send(name) - other.send(name))
          end
        }
      end

    end # module Operators
    include Operators
  end # class Model
end # module Agora
