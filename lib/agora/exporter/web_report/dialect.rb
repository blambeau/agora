require 'base64'
module Agora
  module Exporter
    class WebReport
      class Dialect < WLang::Html

        module Helpers

          def content_of(x)
            file = (Path.pwd/'assets')/x
            raise "Unable to find file `#{file}`" unless file.exists?
            file.read
          end

          def stylesheet(x, buf)
            buf << "<style>"
            buf << content_of(x)
            buf << "</style>"
          end

          def javascript(x, buf)
            buf << %Q{<script>}
            buf << content_of(x)
            buf << "</script>"
          end

          def image(x, buf)
            base64 = Base64.encode64(content_of(x))
            buf << %Q{<div class="model-img"><img src="data:image/png;base64,#{base64}"/></div>}
          # rescue
          #   buf << %Q{<div class="model-img"><img src="data:image/png;base64,"/></div>}
          end

        end
        include Helpers

        def at(buf, fn)
          text  = render(fn) || ''
          links = evaluate('links')
          link  = links.restrict(id: text).tuple_extract
          id, label = link[:id], link[:label]
          buf << %Q{<a href="##{id}">#{label}</a>}
        rescue Alf::NoSuchTupleError
          buf << %Q{#{text} (<span class="missing">to be defined</span>)}
        end

        def less(buf, fn)
          where = render(fn, nil)
          case where
          when /\.css$/ then stylesheet(where, buf)
          when /\.js$/  then javascript(where, buf)
          when /\.png$/ then image(where, buf)
          else
            raise "Unsupported file type `#{where}`"
          end
        end

        def greater(buf, fn)
          tpl = render(fn, "")
          if (tplfile = Path.pwd/"templates/#{tpl}.wlang").exists?
            compiled = self.class.compile(tplfile)
            buf << render(compiled)
          else
            super
          end
        end

        def tilde(buf, fn)
          text = evaluate(fn)
          text = text.read if text.respond_to?(:read)
          if text.nil?
            buf << "<span class='missing'>to be defined</span>"
          else
            buf << Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(text)
          end
        end

        def doublestar(buf, what, body)
          who     = render(what)
          local   = Relation(evaluate(who))
          model   = evaluate('model').send(who)
          inscope = local.join(model)
          inscope.each do |elm|
            render(body, elm, buf)
          end
        end

        tag '@',  :at
        tag '<',  :less
        tag '>',  :greater
        tag '~',  :tilde
        tag '**', :doublestar

      end # class Dialect
    end # class WebReport
  end # module Exporter
end # module Agora
