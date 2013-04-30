module Agora
  module Exporter
    class Dot
      class Dialect < WLang::Html

        module Helpers

          def encode_literal(val)
            '"' << val.to_s.gsub(/"/, '\"') << '"'
          end

          def encode_attributes(hash)
            hash.map{|k,v| "#{k} = #{encode_literal(v)}" }.join(', ')
          end

        end
        include Helpers

        def dotid(buf, fn)
          case val = evaluate(fn)
          when Hash then buf << encode_attributes(val)
          else
            buf << encode_literal(val)
          end
        end

        tag '$',  :dotid

      end # class Dialect
    end # class Dot
  end # module Exporter
end # module Agora
