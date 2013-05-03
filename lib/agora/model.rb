module Agora
  class Model
    include Typed

    attribute :agents, Relation[
      id:   String,
      name: String,
      description: String,
      type: String
    ]

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

    attribute :obstacles, Relation[
      id: String,
      name: String,
      definition: String
    ]

    attribute :refinements, Relation[
      id: String,
      parent: String,
      child: String,
      sysref: String
    ]

    attribute :resolutions, Relation[
      obstacle: String,
      goal: String
    ]

    attribute :assignments, Relation[
      id: String,
      goal: String,
      agent: String,
      sysref: String
    ]

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

    def selection
      self.dup do |s|
        yield(self, s)
      end
    end

    def self.load(file)
      Importer.load(file)
    end

  end # class Model
end # module Agora
require_relative 'model/focus'
