module Agora
  class Model
    class Selection
      include Rules

      def initialize(model)
        @model = model
        @selection = Model.new({})
        @to_apply = []
        yield(self) if block_given?
      end

      Model.each_attribute do |name, type|
        getter, setter = name.to_sym, "#{name}=".to_sym
        define_method(getter) do
          @selection.send(getter)
        end
        define_method(setter) do |value|
          return if value == @selection.send(getter)
          @selection.send(setter, value)
          has_changed(getter)
        end
      end

      def with_ancestors(max = 1000000)
        self.goals += @model.goal_ancestors(self.goals, max)
      end

      def with_descendants(max = 1000000)
        self.goals += @model.goal_descendants(self.goals, max)
      end

      def with_assignments
        self.assignments += (@model.assignments =~ self.goals[goal: :id])
      end

      def to_model
        @selection
      end

      # No assignment without the corresponding agent and goal
      rule(:assignments) do |sel,model|
        sel.agents += (model.agents =~ sel.assignments[id: :agent])
        sel.goals  += (model.goals  =~ sel.assignments[id: :goal])
      end

      # No hidden assignment when both the goal and agent are there
      rule(:agents, :goals) do |sel, model|
        sel.assignments += (model.assignments =~ sel.agents[agent: :id]) \
                         & (model.assignments =~ sel.goals[goal: :id])
      end

      # No goal refinement without the parent goal and refinement children
      rule(:goal_refinements) do |sel, model|
        sel.goals += (model.goals =~ sel.goal_refinements[id: :parent])
        sel.goal_refinement_children += (model.goal_refinement_children =~ sel.goal_refinements[refinement: :id])
      end

      # No goal refinement children without the refinement itself and the child
      rule(:goal_refinement_children) do |sel, model|
        sel.goal_refinements += (model.goal_refinements =~ sel.goal_refinement_children[id: :refinement])
        sel.goals += (model.goals =~ sel.goal_refinement_children[id: :child])
        sel.domain_properties += (model.domain_properties =~ sel.goal_refinement_children[id: :child])
        sel.domain_hypotheses += (model.domain_hypotheses =~ sel.goal_refinement_children[id: :child])
      end

      # No hidden parent/child relationship in goals
      rule(:goals) do |sel, model|
        parent_child = (model.goal_refinements.rename(id: :refinement) * model.goal_refinement_children)
        parent_child = (parent_child =~ sel.goals[parent: :id]) \
                     & (parent_child =~ sel.goals[child: :id])
        sel.goal_refinement_children += (model.goal_refinement_children =~ parent_child)
      end

    end # class Selection
  end # class Model
end # module Agora
