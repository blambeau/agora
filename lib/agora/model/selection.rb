module Agora
  class Model
    class Selection

      def initialize(model)
        @model = model
        @selection = Model.new({})
        @to_apply = []
        yield(self) if block_given?
      end

      Model.attributes.each_pair do |name, type|
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

      def to_model
        @selection
      end

      module Rules

        def rules
          @rules ||= Hash.new{|h,k| h[k] = []}
        end

        def rule(*ons, &bl)
          ons.each do |on|
            rules[on] << bl
          end
        end

      end
      extend Rules

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
        sel.goal_refinement_children += (model.goal_refinement_children =~ sel.goal_refinements[:id])
      end

      # No goal refinement children without the child
      rule(:goal_refinement_children) do |sel, model|
        sel.goals += (model.goals =~ sel.goal_refinement_children[id: :child])
        sel.domain_properties += (model.domain_properties =~ sel.goal_refinement_children[id: :child])
        sel.domain_hypotheses += (model.domain_hypotheses =~ sel.goal_refinement_children[id: :child])
      end

    private

      def has_changed(who)
        @to_apply << who
        apply unless @applying
      end

      def apply
        @applying = true
        until @to_apply.empty?
          self.class.rules[@to_apply.shift].each do |rule|
            rule.call(self, @model)
          end
        end
      ensure
        @applying = false
      end

    end # class Selection
  end # class Model
end # module Agora
