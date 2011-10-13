require 'agora/version'
require 'agora/loader'
require 'pathname'
#
# Agile Goal-Oriented Requirement Acquisition
#
module Agora

  # Loads Agora in a given location
  def self.load(root = ".")
    config = Config.find(root)
  end

end # module Agora
require "agora/goal_model"
require "agora/config"
require "agora/utils"
