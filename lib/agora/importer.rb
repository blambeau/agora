module Agora
  class Importer

    def self.kaos(path)
      unless exporter = ENV['KAOSTOOLS_RELATIONAL_EXPORTER']
        raise "Unable to use KAOSTools, please set KAOSTOOLS_RELATIONAL_EXPORTER"
      end
      Model.new ::JSON.load(`mono --debug "#{exporter}" "#{path}"`)
    end

    def self.json(path)
      Model.new ::JSON.load(path.read)
    end

    def self.load(path, format = nil)
      format ||= format_from_ext(path)
      send(format, path)
    end

    def self.format_from_ext(path)
      path.ext.to_sym
    end

  end # class Importer
end # module Agora
