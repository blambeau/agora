require "yaml"
module Agora
  module GoalModel
    # Provides goal model navigation API on YAML files
    class YAMLBased
    
      # Creates a decoded with brut YAML loaded
      # object
      def initialize(yaml_loaded)
        @yaml_loaded = yaml_loaded
        @goal_model = @yaml_loaded["Goal Model"]
      end
    
      # Parses some YAML text and returns a model 
      # instance
      def self.parse(yaml_text)
        YAMLBased.new YAML::load(yaml_text)
      end
    
      # Parses a YAML file and returns a model instance
      def self.parse_file(filepath)
        parse(File.read(filepath))
      end
    
      # Yields the block with each goal
      def each_goal(&block)
        @goal_model.keys.each(&block)
      end
    
      # Returns the name of a goal
      def goalname(goal)
        goal
      end
    
      # Returns the kind of a goal
      def goalkind(goal)
        g = @goal_model[goal]
        kind = if g["kind"]
          g["kind"]
        elsif goal =~ /^(Maintain|Achieve|Avoid)/
          :goal
        elsif goal =~ /^DomProp/
          :"domain-property"
        elsif goal =~ /^DomHyp/
          :"domain-hypothesis"
        else
          :goal
        end
        kind = kind.to_s.capitalize.gsub(/[-](.)/){ $1.upcase }
        GoalModel.const_get(kind.to_sym)
      end
    
      # Yields the block with each goal refinement
      def each_goal_refinement(goal, &block)
        g = @goal_model[goal]
        refs = (g['refinements'] && g['refinements'].values) ||
               [ g['refinement'] ].compact
        refs.each(&block)
      end
    
      # Yields the block with each subgoal of a refinement
      def each_refinement_subgoal(refinement, &block)
        (refinement['subgoals'] || []).each(&block)
      end
    
      # Yields the block with each goal assignment
      def each_goal_assignment(goal, &block)
        g = @goal_model[goal]
        asss = (g['assignments'] && g['assignments'].values) ||
               [ g['assignment'] ].compact
        asss.each(&block)
      end
    
      # Returns the agent of an assignment
      def assignment_agent(assignment)
        assignment['agent']
      end
    
      # Returns the name of an agent
      def agent_name(agent)
        agent
      end
    
    end # class YAMLBasedModel
  end # module GoalModel
end # module Agora
