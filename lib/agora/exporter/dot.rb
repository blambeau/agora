module Agora
  module Exporter
    class Dot
      include Exporter

      def call
        nodes = model.goals[:id, label: :name] \
              + model.refinements[:id, label: ""] \
              + model.assignments[:id, label: ""] \
              + (model.assignments[:id] * model.agents[agent: :id, label: :name])[:label, id: ->{ "#{id}_ag" }]
        edges = model.refinements[from: :id,    to: :parent, label: :sysref] \
              + model.refinements[from: :child, to: :id,     label: ""] \
              + model.assignments[from: :id,    to: :goal,   label: :sysref] \
              + model.assignments[from: ->{ "#{id}_ag" }, to: :id, label: ""]
        context = {nodes: nodes, edges: edges}
        WLang::Dot.render(Path.dir/"dot/goal-diagram.wlang", context, buf)
      end

    end
  end
  class Model

    def to_dot(buf = "")
      Exporter::Dot.call(self, buf)
    end

  end # class Model
end # module Agora
