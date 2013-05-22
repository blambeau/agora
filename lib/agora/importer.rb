require "open3"
module Agora
  class Importer

    def self.kaos(path)
      unless exporter = ENV['KAOSTOOLS_RELATIONAL_EXPORTER']
        raise "Unable to use KAOSTools, please set KAOSTOOLS_RELATIONAL_EXPORTER"
      end
      Open3.popen3 %Q{mono --debug "#{exporter}" "#{path}"} do |stdin, stdout, stderr, wait_thr|
        pid = wait_thr.pid
        if wait_thr.value.exitstatus == 0
          Model.new ::JSON.load(stdout.read)
        else
          raise SyntaxError, stderr.read[/ParserException:(.*)$/, 1]
        end
      end
    end

    def self.json(path)
      Model.new ::JSON.load(path.read)
    end

    def self.load(path, format = nil)
      format ||= format_from_ext(path)
      if respond_to?(format)
        send(format, path)
      else
        raise UnrecognizedFormatError, "Unrecognized file format `#{format}`"
      end
    end

    def self.format_from_ext(path)
      path.ext.to_sym
    end

  end # class Importer
end # module Agora
