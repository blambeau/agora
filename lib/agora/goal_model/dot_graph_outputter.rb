module Agora
  module GoalModel
    class DotGraphOutputter

      def initialize(model)
        @model = model
      end
  
      def run
        graph = Yargi::Digraph.new
        graph.add_marks(GoalModel::DOT_ATTRIBUTES)
        
        # Keep goal nodes identified by names
        # Any attempt to reach a non-existing goal will immediately
        # create its node. This allows printing graphs for goal models
        # under construction (missing goal entry for refinement subgoal,
        # in particular)
        goal_nodes = Hash.new{|h,k|
          kind = @model.goalkind(k)
          h[k] = graph.add_vertex(
            kind, 
            kind::DOT_ATTRIBUTES,
            :label => goalname2label(k)
          )
        }
    
        # create all nodes for goals
        @model.each_goal do |goal|
          goal_nodes[goal]
        end
    
        # create refinements and assignments
        @model.each_goal do |goal|
        
          # refinements
          @model.each_goal_refinement(goal) do |ref|
          
            # refinement bullet
            refn = graph.add_vertex(
              GoalModel::AndRefinement,
              GoalModel::AndRefinement::DOT_ATTRIBUTES)
            graph.connect(refn, goal_nodes[goal])
        
            # connect subgoals
            @model.each_refinement_subgoal(ref) do |subgoal|
              graph.connect(goal_nodes[subgoal], refn, :arrowhead => "none")
            end
        
          end # refinements

          @model.each_goal_assignment(goal) do |ass|
          
            # assignment bullet
            assn = graph.add_vertex(
              GoalModel::Assignment,
              GoalModel::Assignment::DOT_ATTRIBUTES
            )
            graph.connect(assn, goal_nodes[goal])
        
            # agent
            agentn = graph.add_vertex(
              GoalModel::Agent,
              GoalModel::Agent::DOT_ATTRIBUTES,
              :label => @model.agent_name(@model.assignment_agent(ass))
            )
            graph.connect(agentn, assn, :arrowhead => "none")
          
          end # assignments
        
        end # refinements and assignments
    
        graph
      end
  
      def goalname2label(goalname)
        words = goalname.split(/\s/)
        buffer, curword = "", words.shift
        until words.empty?
          if buffer.empty?
            buffer << "\n" << curword
            curword = ""
          elsif (curword.length > 15 || (curword.length + words.first.length > 20))
            buffer << "\n" << curword
            curword = ""
          else
            curword << " " << words.shift
          end
        end
        (buffer << "\n" << curword) unless curword.empty?
        label = buffer.strip.gsub("\n", '\n')
        label
      end

    end # DotGraphOutputter
  end # module GoalModel
end # module Agora
