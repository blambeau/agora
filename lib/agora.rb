require_relative 'agora/version'
require_relative 'agora/loader'
require 'json'
#
# Agile Goal-Oriented Requirement Acquisition
#
module Agora

  Error       = Class.new(StandardError)
  SyntaxError = Class.new(Error)
  UnrecognizedFormatError = Class.new(Error)

end # module Agora
require_relative 'agora/support'
require_relative 'agora/importer'
require_relative 'agora/model'
require_relative 'agora/exporter'
require_relative 'agora/command'
