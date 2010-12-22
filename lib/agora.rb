begin
  require 'yargi'
rescue LoadError
  require 'rubygems'
  gem 'yargi', '>= 0.1.1'
  require 'yargi'
end
require 'pathname'

module Agora

  VERSION = '0.1.1'

end # module Agora
require "agora/goal_model"
require "agora/config"
require "agora/utils"
