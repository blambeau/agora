module Agora
  module Exporter
    class KaosTools
      include Exporter

      def call
        Dialect.render(Path.dir/"kaos_tools/kaos.wlang", self, buf)
      end

      ### AGENT declarations

      def agent_declarations
        model.agents
      end

      ### DOMAIN descriptions

      def domprop_declarations
        model.domain_properties
      end

      def domhyp_declarations
        model.domain_hypotheses
      end

      ### GOAL declarations

      def goal_declarations
        model.goals * refinedby * assignedto
      end

      # Relation[id: String, refinedby: Relation[child: String]]
      def refinedby
        refs = model.refinement_children[:child, id: :refinement]
                    .join(model.refinements)[:child, id: :parent]
        structure(refs, :refinedby)
      end

      # Relation[id: String, assignedto: Relation[child: String]]
      def assignedto
        assign = model.assignments[id: :goal, child: :agent]
        structure(assign, :assignedto)
      end

    private

      def structure(rel, as)
        match   = rel.group([:id], :children, allbut: true).group([:children], as)
        nomatch = model.goals[:id].not_matching(match).extend(as => Relation::DUM)
        match + nomatch
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
