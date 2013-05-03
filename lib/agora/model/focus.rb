module Agora
  class Model

    def ancestors(selection)
      selection = Relation(selection) unless selection.is_a?(Relation)
      parents = (refinements =~ selection)
      if parents.empty?
        selection
      else
        selection + ancestors(parents[child: :parent])
      end
    end

    #
    # Rule 1: no incomplete refinement
    #
    #   1.1 -> refinement_children += (model.refinement_children =~ sel.refinements)
    #   1.2 -> goals += (model.goals =~ sel.refinement_children[id: :child])
    #
    # Rule 2: no hidden parent/child relationship
    #
    #   1.1 -> refinement_children += (model.refinements =~ sel.parent_child[parent: id])
    #                               & (model.refinements =~ sel.parent_child[child: id])
    #

    def focus(sel)
    end

  end # class Model
end # module Agora
