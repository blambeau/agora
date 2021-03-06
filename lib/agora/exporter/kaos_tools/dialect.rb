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
          attrname = render(fn)
          if value = evaluate(attrname)
            buf << attrname << " " << quotize(value)
          end
        end

        def doublestar(buf, fn)
          name = render(fn)
          what = evaluate(name)
          what.to_a.each_with_index do |tuple,i|
            buf << "  " if i != 0
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
