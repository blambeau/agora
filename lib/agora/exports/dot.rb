module Agora
  class Model

    def to_dot(buf = "")
      nodes = goals[:id, label: :name] \
            + refinements[:id, label: ""] \
            + assignments[:id, label: ""] \
            + (assignments[:id] * agents[agent: :id, label: :name])[:label, id: ->{ "#{id}_ag" }]
      edges = refinements[from: :id,    to: :parent, label: :sysref] \
            + refinements[from: :child, to: :id,     label: ""] \
            + assignments[from: :id,    to: :goal,   label: :sysref] \
            + assignments[from: ->{ "#{id}_ag" }, to: :id, label: ""]
      context = {nodes: nodes, edges: edges}
      WLang::Dot.render(Path.dir/"dot.wlang", context, buf)
    end

  end # class Model
end # module Agora
