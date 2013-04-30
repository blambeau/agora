module Agora
  module Exporter

    def initialize(model, buf)
      @model  = model
      @buf    = buf
    end
    attr_reader :model, :buf

    def self.included(x)
      def x.call(*args)
        new(*args).call
      end
    end

  end # module Exporter
end # module Agora
require_relative 'exporter/kaos_tools'
require_relative 'exporter/dot'
require_relative 'exporter/web_report'
