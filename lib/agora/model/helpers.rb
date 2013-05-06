module Agora
  class Model
    module Helpers

      # Relation[refinement: String, parent: String, child: String]
      def goals_parent_child
        goal_refinements.rename(id: :refinement) * goal_refinement_children
      end

      def goal_ancestor_ids(goals, max = 1_000_000, n = 0)
        return goals if n >= max
        parents = (goals_parent_child =~ goals[child: :id])[id: :parent]
        parents.empty? ? goals : goals + goal_ancestor_ids(parents, max, n+1)
      end

      def goal_ancestors(goals, max = 1_000_000, n = 0)
        self.goals =~ goal_ancestor_ids(goals[:id], max, n)
      end

    end # module Helpers
  end # class Model
end # module Agora
