module Agora
  class Model

    def to_kaos(buf = "")
      WLang::Html.render(Path.dir/"kaos.wlang", self, buf)
    end

  end # class Model
end # module Agora
