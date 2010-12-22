begin
  require 'yargi'
rescue LoadError
  require 'rubygems'
  gem 'yargi', '>= 0.1.1'
  require 'yargi'
end
require 'pathname'

#
# Agile Goal-Oriented Requirement Acquisition
#
module Agora

  VERSION = '0.1.1'
  
  # Loads Agora in a given location
  def self.load(root = ".")
    config = Config.find(root)
  end

end # module Agora
require "agora/goal_model"
require "agora/config"
require "agora/utils"
