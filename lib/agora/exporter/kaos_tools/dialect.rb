module Agora
  module Exporter
    class KaosTools
      class Dialect < WLang::Html

        module Helpers

          def quotize(x)
            %Q{"#{x.gsub(/"/, '""')}"}
          end

        end
        include Helpers

        def quote(buf, fn)
          buf << quotize(evaluate(fn) || "")
        end

        def doublestar(buf, fn)
          name = render(fn)
          what = evaluate(name)
          what.each do |tuple|
            sysref   = tuple[:sysref]
            sysref   = sysref ? "[#{sysref}] " : " "
            children = tuple[:children].map{|t| t[:child]}
            buf << name << sysref << children.join(", ") << "\n"
          end
        end

        tag '"',  :quote
        tag '**', :doublestar

      end # class Dialect
    end # module KaosTools
  end # module Exporter
end # module Agora
