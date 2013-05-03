module Agora
  module Exporter
    class Json
      include Exporter

      def call
        buf << ::JSON.dump(model.to_hash)
      end

    end
  end
  class Model

    def to_json(buf = "")
      Exporter::Json.call(self, buf)
    end

  end # class Model
end # module Agora
