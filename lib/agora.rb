begin
  require 'yargi'
rescue LoadError
  require 'rubygems'
  gem 'yargi', '>= 0.1.1'
  require 'yargi'
end

module Agora

  VERSION = '0.1.0'

end # module Agora
require "agora/goal_model"
