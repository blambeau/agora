module Agora
  module Exporter
    class Dot
      include Exporter

      NodeAttributes = Alf::Relation.coerce(Path.dir/"dot/node_attributes.rash")
      EdgeAttributes = Alf::Relation.coerce(Path.dir/"dot/edge_attributes.rash")

      def nodes
        nodes = model.goals[:id, label: :name, kind: "goal"] \
              + model.domain_properties[:id, label: :name, kind: "domain-property"] \
              + model.domain_hypotheses[:id, label: :name, kind: "domain-hypothesis"] \
              + model.goal_refinements[:id, label: "", kind: "refinement"] \
              + model.assignments[:id, label: "", kind: "assignment"] \
              + (model.assignments[:id] *
                 model.agents[agent: :id, label: :name])[:label, id: ->{ "#{id}_ag" }, kind: "agent"]
        nodes = (nodes * NodeAttributes).wrap([:id, :kind], :attributes, allbut: true)
        nodes
      end

      def edges
        edges = model.goal_refinements[from: :id,              to: :parent,     label: "", kind: "refinement"] \
              + model.goal_refinement_children[from: :child,   to: :refinement, label: "", kind: "none"] \
              + model.assignments[from: :id,              to: :goal,       label: "", kind: "assignment"] \
              + model.assignments[from: ->{ "#{id}_ag" }, to: :id,         label: "", kind: "none"]
        edges = (edges * EdgeAttributes).wrap([:from, :to, :kind], :attributes, allbut: true)
        edges
      end

      def call
        Dialect.render(Path.dir/"dot/goal-diagram.wlang", self, buf)
      end

    end
  end
  class Model

    def to_dot(buf = "")
      Exporter::Dot.call(self, buf)
    end

  end # class Model
end # module Agora
require_relative "dot/dialect"
