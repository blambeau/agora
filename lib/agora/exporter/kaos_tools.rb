module Agora
  module Exporter
    class KaosTools
      include Exporter

      def call
        got = Dialect.render(Path.dir/"kaos_tools/kaos.wlang", self, buf)
        got.gsub(/[ ]+\n/m, "\n").gsub(/^\n/, "")
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
        model.goals * refinedby * assignedto * obstructedby
      end

      # Relation[id: String, refinedby: Relation[child: String]]
      def refinedby
        refs     = model.refinements
        children = model.refinement_children.rename(:refinement => :id)
        structure(refs * children, :refinedby)
      end

      # Relation[id: String, assignedto: Relation[child: String]]
      def assignedto
        assign = model.assignments.rename(goal: :parent, agent: :child)
        structure(assign, :assignedto)
      end

      # Relation[id: String, obstructedby: Relation[child: String]]
      def obstructedby
        obstructions = model.obstructions.rename(goal: :parent, obstacle: :child)
        structure(obstructions, :obstructedby)
      end

      ### OBSTACLE declarations

      def obstacle_declarations
        model.obstacles * resolvedby
      end

      def resolvedby
        resolutions = model.resolutions.rename(obstacle: :parent, goal: :child)
        structure(resolutions, :resolvedby)
      end

    private

      def structure(rel, as)
        match   = rel.group([:child], :children)
                     .group([:parent], as, allbut: true)
                     .rename(:parent => :id)
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
