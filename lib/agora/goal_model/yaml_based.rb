require "yaml"
module Agora
  module GoalModel
    # Provides goal model navigation API on YAML files
    class YAMLBased
    
      DEFAULT_OPTIONS = {
        :load_extra_documents => true
      }
    
      # Creates a decoded with brut YAML loaded
      # object
      def initialize(yaml_loaded)
        @yaml_loaded = yaml_loaded
        @agent_model = @yaml_loaded["Agent Model"] || {}
        @goal_model  = @yaml_loaded["Goal Model"]  || {}
      end
      attr_reader :yaml_loaded
    
      # Loads a model from a file, taking care of loading 
      # and merging extra documents 
      def self.load(file, options = {})
        file = File.expand_path(file)
        options = DEFAULT_OPTIONS.merge(options)
        loaded = Agora::YAMLUtils.file_load(file, {
          :recursive => options[:load_extra_documents]
        }) do |file, loaded, options|
          docs = loaded['about'] && loaded['about']['documents']
          (docs || []).collect{|f|
            File.expand_path(File.join(File.dirname(file), f))
          }
        end
        YAMLBased.new loaded
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
      alias :_obstacle_info :_goal_info
    
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
    
      # Returns the kind of an object
      def kind_of(obj)
        g = _goal_info(obj)
        kind = if g["kind"]
          g["kind"]
        elsif obj =~ /^DomProp/
          :"domain-property"
        elsif obj =~ /^DomHyp/
          :"domain-hypothesis"
        else
          if is_expectation?(obj)
            :expectation
          elsif is_requirement?(obj)
            :requirement
          else
            :goal
          end
        end
        kind = kind.to_s.capitalize.gsub(/[-](.)/){ $1.upcase }
        GoalModel.const_get(kind.to_sym)
      end
    
      # Yields the block with each object in turn
      def each_object(&block)
        @goal_model.keys.each(&block)
      end
      
      # Returns the name of a goal
      def goalname(goal)
        goal
      end
    
      # Yields the block with each goal
      def each_goal
        each_object{|obj|
          yield(obj) if is_goal?(obj)
        }
      end
      
      # Yields the block with each obstacle
      def each_obstacle
        each_object{|obj|
          yield(obj) if is_obstacle?(obj)
        }
      end
      
      # Yields the block with each refinement of a goal/obstacle
      def each_refinement(goal, &block)
        g = _goal_info(goal)
        refs = (g['refinements'] && g['refinements'].values) ||
               (g['or-refinement'] && g['or-refinement']) ||
               [ g['refinement'] ].compact
        refs.each(&block)
      end
    
      # Yields the block with each subgoal of a refinement
      def each_refinement_subgoal(refinement, &block)
        case refinement
          when Hash
            (refinement['subgoals'] || []).each(&block)
          when String
            block.call(refinement)
          else
            raise "Unexpected refinement #{refinement}"
        end
      end
      
      # Yields the block with each obstacle resolution in turn
      def each_obstacle_resolution(obs, &block)
        obs = _obstacle_info(obs)
        resolutions = if obs['resolution']
          [ obs['resolution'] ].flatten
        elsif obs['resolutions']
          obs['resolutions']
        else
          []
        end
        resolutions.each(&block)
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
      
      # Returns true if obj is a goal
      def is_goal?(obj)
        GoalModel::Obstacle != kind_of(obj)
      end
      
      # Returns true if obj is an obstacle
      def is_obstacle?(obj)
        GoalModel::Obstacle == kind_of(obj)
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
      
      # Returns obstructed goal for an obstacle
      def obstructed_goal(obs)
        obs = _obstacle_info(obs)
        obs["obstruct"]
      end
    
    end # class YAMLBasedModel
  end # module GoalModel
end # module Agora
