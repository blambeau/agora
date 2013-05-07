module Agora
  class Model
    module Operators

      def selection
        Selection.new(self, &Proc.new).to_model
      end
      alias :select :selection

    end # module Operators
    include Operators
  end # class Model
end # module Agora
