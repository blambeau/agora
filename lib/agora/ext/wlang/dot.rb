module WLang
  class Dot < WLang::Html

    module Helpers
    end
    include Helpers

    def dotid(buf, fn)
      id = evaluate(fn)
      buf << '"' << id.gsub(/"/, '\"') << '"'
    end

    tag '$',  :dotid

  end
end
