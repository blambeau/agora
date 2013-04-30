module Agora
  module Exporter
    class KaosTools
      include Exporter

      def agents
        model.agents
      end

      def refinedby
        refs   = model.refinements.group([:child], :children)
                                  .group([:parent], :refinedby, allbut: true)
                                  .rename(:parent => :id)
        norefs = model.goals[:id].not_matching(refs)
                   .extend(:refinedby => Relation::DUM)
        refs + norefs
      end

      def assignedto
        assign = model.assignments.rename(:agent => :child)
                                  .group([:child], :children)
                                  .group([:goal],  :assignedto, allbut: true)
                                  .rename(:goal => :id)
        noassi = model.goals[:id].not_matching(assign)
                   .extend(:assignedto => Relation::DUM)
        assign + noassi
      end

      def goals
        model.goals * refinedby * assignedto
      end

      def call
        Dialect.render(Path.dir/"kaos_tools/kaos.wlang", self, buf)
      end

    end # class KaosTools
  end # module Exporter
  class Model

    def to_kaos(buf = "")
      Exporter::KaosTools.call(self, buf)
    end

  end # class Model
end # module Agora
require_relative 'kaos_tools/dialect'