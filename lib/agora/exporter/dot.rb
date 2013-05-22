module Agora
  module Exporter
    class Dot
      include Exporter

      NodeAttributes = Alf::Relation.coerce(Path.dir/"dot/node_attributes.rash")
      EdgeAttributes = Alf::Relation.coerce(Path.dir/"dot/edge_attributes.rash")

      module Helpers

        def split_label(label, max = 23)
          words, buf, cur = label.split(/\s/), "", 0
          until words.empty?
            word = words.shift
            if (cur + word.length) > max
              buf << '\n'
              cur = 0
            else
              buf << " " unless cur == 0
            end
            buf << word
            cur += word.size
          end
          buf
        end
      end
      include Helpers

      def height(label)
        return 0 if label.empty?
        lines = 1 + label.scan('\n').length
        0.2 + lines * 0.22
      end

      def name2label(x)
        h = self
        x.extend(label: ->{ h.split_label(name || id) })
      end

      def nodes
        h = self
        agents = name2label(model.agents)[:label, agent: :id]
        nodes = name2label(model.goals)[:id, :label, kind: "goal"] \
              + name2label(model.domain_properties)[:id, :label, kind: "domain-property"] \
              + name2label(model.domain_hypotheses)[:id, :label, kind: "domain-hypothesis"] \
              + model.goal_refinements[:id, label: "", kind: "refinement"] \
              + model.assignments[:id, label: "", kind: "assignment"] \
              + (model.assignments[:id, :agent] * agents)[:label, id: ->{ "#{id}_ag" }, kind: "agent"]
        nodes = nodes.extend(height: ->{ h.height(label) })
        nodes = (nodes * NodeAttributes).wrap([:id, :kind], :attributes, allbut: true)
        nodes
      end

      def edges
        h = self
        edges = model.goal_refinements[from: :id, to: :parent, label: "", kind: "refinement"] \
              + model.goal_refinement_children[from: :child, to: :refinement, label: "", kind: "none"] \
              + model.assignments[from: :id, to: :goal, label: "", kind: "assignment"] \
              + model.assignments[from: ->{ "#{id}_ag" }, to: :id, label: "", kind: "none"]
        edges = edges.extend(label: ->{ h.split_label(label) })
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
