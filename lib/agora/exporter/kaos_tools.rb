module Agora
  module Exporter
    class KaosTools
      include Exporter

      def agents
        model.agents
      end

      def structure(rel, as)
        rel.group([:id], :children, allbut: true).group([:children], as)
      end

      # Relation[id: String, refinedby: Relation[child: String]]
      def refinedby
        # 1) goals that are refined
        #
        # id: String, child: String, parent: String
        refs = model.refinement_children[:child, id: :refinement]
                    .join(model.refinements)
        # id: String, child: String
        refs = refs[:child, id: :parent]
        # id: String, refinedby: Relation[children: Relation[child: String]]
        refs = structure(refs, :refinedby)

        # 2) goals not refined
        norefs = model.goals[:id].not_matching(refs)
                   .extend(:refinedby => Relation::DUM)

        # both
        refs + norefs
      end

      # Relation[id: String, assignedto: Relation[child: String]]
      def assignedto
        # 1) goals that are assigned
        #
        # Relation[id: String, goal: String, agent: String]
        assign = model.assignments
        # Relation[id: String, child: String]
        assign = assign[id: :goal, child: :agent]
        # Relation[id: String, assignedto: Relation[children: Relation[child: String]]]
        assign = structure(assign, :assignedto)

        # 2) not assigned
        noassi = model.goals[:id].not_matching(assign)
                   .extend(:assignedto => Relation::DUM)

        # both
        assign + noassi
      end

      def goals
        model.goals * refinedby * assignedto
      end

      def call
        Dialect.render(Path.dir/"kaos_tools/kaos.wlang", self, buf)
      end

    end # class KaosTools
  end # module Exporter
  class Model

    def to_kaos(buf = "")
      Exporter::KaosTools.call(self, buf)
    end

  end # class Model
end # module Agora
require_relative 'kaos_tools/dialect'