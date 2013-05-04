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
        model.goals * goals_refinedby * assignedto * obstructedby
      end

      def goals_refinedby
        refs     = model.goal_refinements
        children = model.goal_refinement_children.rename(:refinement => :id)
        structure(refs * children, :refinedby, model.goals)
      end

      def assignedto
        assign = model.assignments.rename(goal: :parent, agent: :child)
        structure(assign, :assignedto, model.goals)
      end

      def obstructedby
        obstructions = model.obstructions.rename(goal: :parent, obstacle: :child)
        structure(obstructions, :obstructedby, model.goals)
      end

      ### OBSTACLE declarations

      def obstacle_declarations
        model.obstacles * resolvedby * obstacles_refinedby
      end

      def obstacles_refinedby
        refs     = model.obstacle_refinements
        children = model.obstacle_refinement_children.rename(:refinement => :id)
        structure(refs * children, :refinedby, model.obstacles)
      end

      def resolvedby
        resolutions = model.resolutions.rename(obstacle: :parent, goal: :child)
        structure(resolutions, :resolvedby, model.obstacles)
      end

    private

      def structure(rel, as, through)
        match   = rel.group([:child], :children)
                     .group([:parent], as, allbut: true)
                     .rename(:parent => :id)
        nomatch = through[:id].not_matching(match).extend(as => Relation::DUM)
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
