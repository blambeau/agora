module Agora
  class Model

    def ancestors(selection)
      parents = (refinements =~ selection)
      if parents.empty?
        selection
      else
        selection + ancestors(parents[child: :parent])
      end
    end

    def focus(selection)
      # involved parent/child links
      refs   = (self.refinements =~ selection[parent: :id]) \
             & (self.refinements =~ selection[child: :id])

      # complete involved refinements
      refs = (self.refinements =~ refs[:parent])

      # goals involved in selected refinements
      goals = (self.goals =~ refs[id: :parent]) \
            + (self.goals =~ refs[id: :child])

      # assignments for selected goals
      assignments = (self.assignments =~ goals[goal: :id])

      # agents in selected assignments
      agents = (self.agents =~ assignments[id: :agent])

      # insystems for selected goals only
      insystem = (self.insystem =~ goals[goal: :id])

      Model.new({  
             agents: agents,
              goals: goals,
        refinements: refs,
        assignments: assignments,
           insystem: insystem})
    end

  end # class Model
end # module Agora
