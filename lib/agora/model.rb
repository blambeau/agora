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

    attribute :refinements, Relation[
      id: String, 
      parent: String, 
      child: String, 
      sysref: String
    ]

    attribute :assignments, Relation[
      id: String,
      goal: String,
      agent: String,
      sysref: String
    ]

    attribute :insystem, Relation[
      goal: String,
      system: String
    ]

    def self.load(file)
      new Path(file).load
    end

  end # class Model
end # module Agora
require_relative 'model/focus'
