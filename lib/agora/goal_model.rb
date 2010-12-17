module Agora
  module GoalModel

    DOT_ATTRIBUTES = {
      :rankdir => "BT", 
      :ranksep => 0.2,
      # :nodesep => 0.2
    }
    
    # Loads a goal model from a YAML text
    def self.yaml_load(text)
      Agora::GoalModel::YAMLBased.parse(text)
    end
    
    # Loads a goal model from a YAML file
    def self.yaml_file_load(filepath)
      Agora::GoalModel::YAMLBased.parse_file(filepath)
    end
    
    # Marker for goals
    module Goal
    
      DOT_ATTRIBUTES = {
        :shape => "polygon",
        :skew => 0.3,
        :margin => "0", 
        :style => "filled",
        :fillcolor => "#D7E6EE",
        :fontname => "Helvetica",
        :fontsize => 12.0,
      }
    
    end # module Goal

    # Marker for expectations
    module Expectation
    
      DOT_ATTRIBUTES = {
        :shape => "polygon",
        :skew => 0.3,
        :margin => "0",
        :style => "filled",
        :fillcolor => "#FFDE3F",
        :fontname => "Helvetica",
        :fontsize => 12.0,
        :penwidth => 2.0
      }
    
    end # module Goal

    # Marker for requirements
    module Requirement
    
      DOT_ATTRIBUTES = {
        :shape => "polygon",
        :skew => 0.3,
        :margin => "0",
        :style => "filled",
        :fillcolor => "#D7E6EE",
        :fontname => "Helvetica",
        :fontsize => 12.0,
        :penwidth => 2.0
      }
    
    end # module Requirement

    # Marker for domain hypotheses
    module DomainHypothesis
    
      DOT_ATTRIBUTES = {
        :shape => "house",
        :style => "filled",
        :fillcolor => "#C4B5DA",
        :fontname => "Helvetica",
        :fontsize => 12.0,
        :margin => "0, 0.01" 
      }
    
    end # module DomainHypothesis
  
    # Marker for domain properties
    module DomainProperty

      DOT_ATTRIBUTES = {
        :shape => "house",
        :style => "filled",
        :fillcolor => "#C4B5DA",
        :fontname => "Helvetica",
        :fontsize => 12.0,
        :margin => "0, 0.01" 
      }

    end # module DomainProperty
  
    # Marker for agents
    module Agent

      DOT_ATTRIBUTES = { 
        :shape => "hexagon",
        :style => "filled",
        :fillcolor => "#FFFFE3",
        :fontname => "Helvetica",
        :fontsize => 12.0,
        :margin => "0.15, 0.02",
        :height => 0.4 
      }

    end # module Agent
  
    # Marker for and-refinement 
    module AndRefinement
    
      DOT_ATTRIBUTES = {
        :label => "",
        :shape => "circle",
        :label => "",
        :style => "filled",
        :fillcolor => "#FFDE3F",
        :width => 0.15,
        :height => 0.15,
        :fixedsize => true      
      }
    
    end # module AndRefinement
  
    # Marker for assignments
    module Assignment

      DOT_ATTRIBUTES = {
        :label => "",
        :shape => "circle",
        :label => "",
        :style => "filled",
        :fillcolor => "#CC0000",
        :width => 0.15,
        :height => 0.15,
        :fixedsize => true
      }

    end # module Assignment
    
    # Marker for obstacles
    module Obstacle
    
      DOT_ATTRIBUTES = {
        :shape => "polygon",
        :skew => -0.3,
        :margin => "0",
        :style => "filled",
        :fillcolor => "#FF9D80",
        :fontname => "Helvetica",
        :fontsize => 12.0,
      }
    
    end # module Obstacle

    # Marker for expectations
    module Fake

      DOT_ATTRIBUTES = {
        :shape => "circle",
        :margin => "0",
        :fixedsize => true,
        :width => 0.001,
        :height => 0.001,
        :visible => false,
        :style => "filled",
        :fillcolor => "white",
        :color => 'white',
        :label => ""
      }

    end 
    
  end # module GoalModel
end # module Agora
require "agora/goal_model/yaml_based"
require "agora/goal_model/dot_graph_outputter"