require "yaml"
module Agora
  module GoalModel
    # Provides goal model navigation API on YAML files
    class YAMLBased
    
      # Creates a decoded with brut YAML loaded
      # object
      def initialize(yaml_loaded)
        @yaml_loaded = yaml_loaded
        @agent_model = @yaml_loaded["Agent Model"] || {}
        @goal_model  = @yaml_loaded["Goal Model"]  || {}
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
      
      # Returns goal information for a given goal name
      def _goal_info(goalname, default = {})
        if @goal_model.has_key?(goalname)
          @goal_model[goalname]
        elsif default
          default
        else
          raise "No such goal #{goalname}"
        end
      end
    
      # Returns agent information for a given agent name
      def _agent_info(agent_name, default = {})
        if @agent_model.has_key?(agent_name)
          @agent_model[agent_name]
        elsif default
          default
        else
          raise "No such agent #{agent_name}"
        end
      end
    
      # Returns the name of a goal
      def goalname(goal)
        goal
      end
    
      # Returns the kind of a goal
      def goalkind(goal)
        g = _goal_info(goal)
        kind = if g["kind"]
          g["kind"]
        elsif goal =~ /^DomProp/
          :"domain-property"
        elsif goal =~ /^DomHyp/
          :"domain-hypothesis"
        else
          if is_expectation?(goal)
            :expectation
          elsif is_requirement?(goal)
            :requirement
          else
            :goal
          end
        end
        kind = kind.to_s.capitalize.gsub(/[-](.)/){ $1.upcase }
        GoalModel.const_get(kind.to_sym)
      end
    
      # Yields the block with each goal refinement
      def each_goal_refinement(goal, &block)
        g = _goal_info(goal)
        refs = (g['refinements'] && g['refinements'].values) ||
               [ g['refinement'] ].compact
        refs.each(&block)
      end
    
      # Yields the block with each subgoal of a refinement
      def each_refinement_subgoal(refinement, &block)
        (refinement['subgoals'] || []).each(&block)
      end
    
      # Returns an enumerable with goal assignments
      def goal_assignments(goal)
        g = _goal_info(goal)
        (g['assignments'] && g['assignments'].values) ||
        [ g['assignment'] ].compact
      end
    
      # Yields the block with each goal assignment
      def each_goal_assignment(goal, &block)
        goal_assignments(goal).each(&block)
      end
      
      # Returns true is a goal is assigned, false otherwise
      def is_assigned?(goal)
        !goal_assignments(goal).empty?
      end
      
      # Returns true if a goal is a requirement, false otherwise
      def is_requirement?(goal)
        asss = goal_assignments(goal)
        !asss.empty? && is_software_agent?(assignment_agent(asss.first))
      end
      
      # Returns true if a goal is an expectation, false otherwise
      def is_expectation?(goal)
        asss = goal_assignments(goal)
        !asss.empty? && is_environment_agent?(assignment_agent(asss.first))
      end
    
      # Returns the agent of an assignment
      def assignment_agent(assignment)
        assignment['agent']
      end
    
      # Returns the name of an agent
      def agent_name(agent)
        agent
      end
      
      # Checks if an agent is a software agent
      def is_software_agent?(agent)
        ag = _agent_info(agent)
        ag['kind'] == 'software'
      end
    
      # Checks if an agent is an environment agent
      def is_environment_agent?(agent)
        ag = _agent_info(agent)
        ag['kind'] == 'environment'
      end
    
    end # class YAMLBasedModel
  end # module GoalModel
end # module Agora
