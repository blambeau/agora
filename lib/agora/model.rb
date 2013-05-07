module Agora
  class Model
    include Typed

    ### IDEAL GOAL MODEL

    attribute :goals, Relation[
      id: String,
      name: String,
      definition: String
    ]

    attribute :domain_properties, Relation[
      id: String,
      name: String,
      definition: String
    ]

    attribute :domain_hypotheses, Relation[
      id: String,
      name: String,
      definition: String
    ]

    attribute :goal_refinements, Relation[
      id: String,
      parent: String,
    ]

    attribute :goal_refinement_children, Relation[
      refinement: String,
      child: String,
    ]

    ### OBSTACLE ANALYSIS

    attribute :obstacles, Relation[
      id: String,
      name: String,
      definition: String
    ]

    attribute :obstacle_refinements, Relation[
      id: String,
      parent: String,
    ]

    attribute :obstacle_refinement_children, Relation[
      refinement: String,
      child: String,
    ]

    attribute :obstructions, Relation[
      goal: String,
      obstacle: String
    ]

    attribute :resolutions, Relation[
      goal: String,
      obstacle: String
    ]

    ### AGENT MODEL

    attribute :agents, Relation[
      id:   String,
      name: String,
      description: String,
      type: String
    ]

    attribute :assignments, Relation[
      id: String,
      goal: String,
      agent: String,
    ]

    ### OTHER ORTHOGONAL FEATURES

    attribute :predicates, Relation[
      id: String,
      name: String,
      signature: String,
      definition: String
    ]

    attribute :insystem, Relation[
      goal: String,
      system: String
    ]

    def self.load(file)
      Importer.load(file)
    end

    require_relative 'model/helpers'
    include Helpers
  end # class Model
end # module Agora
require_relative 'model/selection'
require_relative 'model/operators'
