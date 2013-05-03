module Agora
  class Importer

    Path.register_loader(".kaos") do |file|
      unless exporter = ENV['KAOSTOOLS_RELATIONAL_EXPORTER']
        raise "Unable to use KAOSTools, please set KAOSTOOLS_RELATIONAL_EXPORTER"
      end
      ::JSON.load `mono #{exporter} #{file}`
    end

    def self.load(path)
      Model.new Path(path).load
    end

  end # class Importer
end # module Agora
