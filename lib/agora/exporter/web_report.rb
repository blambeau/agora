module Agora
  module Exporter
    class WebReport
      include Exporter

      def initialize(model, folder, buf)
        super(model, buf)
        @folder = folder
      end
      attr_reader :folder

      def call
        Dialect.render(folder/"templates/html5.wlang", context, buf)
      end

    private

      def context
        context = {}

        # merge every .yml in the content folder
        (folder/"content").glob("*.yml").each do |yml|
          context.merge!(yml.load)
        end

        # add content of every .md file
        (folder/"content").glob("*.md").each do |md|
          context[md.basename.rm_ext.to_s] = md.read
        end

        # add model artifacts
        context["model"] = model

        # Linkable information
        context["links"] = model.goals[id: :id, label: :name]

        context
      end

    end # WebReport
  end # module Exporter
  class Model

    def resolving_goals
      goals =~ resolutions[id: :goal]
    end

  end
end # module Agora
require_relative 'web_report/dialect'
