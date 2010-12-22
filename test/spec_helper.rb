dir = File.dirname(__FILE__)
$LOAD_PATH.unshift "#{dir}/../lib"

require 'rubygems'
require 'spec'
require 'pp'
require 'fileutils'
require 'agora'

Spec::Runner.configure do |config|
end

module Agora

  FIXTURES_PATHNAME = Pathname.new('../fixtures').expand_path(__FILE__)
  
end # module Agora

