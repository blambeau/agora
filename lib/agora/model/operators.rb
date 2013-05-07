module Agora
  class Model
    module Operators

      def select
        Selection.new(self, &Proc.new).to_model
      end

    end # module Operators
    include Operators
  end # class Model
end # module Agora
