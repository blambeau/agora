module Agora
  #
  # Agile Goal-Oriented Requirement Acquisition
  #
  # SYNOPSIS
  #   #{program_name} [--help] [--version] [MODEL]
  #
  # OPTIONS
  # #{summarized_options}
  #
  # DESCRIPTION
  #   Runs a convertion/check on a Kaos model and returns the result
  #   on standard output
  #
  class Command < Quickl::Command(__FILE__, __LINE__)
  
    # Install command options
    options do |opt|
      @output = :kaos
      opt.on('--kaos', "Outputs result as a .kaos file") do
        @output = :kaos
      end
      opt.on('--json', "Outputs result as a .json file") do
        @output = :json
      end
      opt.on('--dot', "Outputs result as a graphviz .dot file") do
        @output = :dot
      end
      opt.on_tail("--help", "Show help") do
        raise Quickl::Help
      end
      opt.on_tail("--version", "Show version") do
        raise Quickl::Exit, "#{Quickl.program_name} #{Agora::VERSION} (c) 2013, Bernard Lambeau"
      end
    end

    # Execute the command on some arguments
    def execute(args)
      if args.size == 1
        model = Model.load(Path(args.first))
        model.send("to_#{@output}".to_sym, STDOUT)
      else
        raise Quickl::InvalidArgument, "Useless arguments: #{args.join(' ')}"
      end
    end
  
  end # class Command
end # module Agora
