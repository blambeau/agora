$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'agora'

module Helpers

  def fixtures
    Path.dir/"fixtures"
  end

  def examples_folder
    Path.backfind("agora/examples")
  end

  def examples
    examples_folder.glob("*.json")
  end

  def minepump_model
    Agora::Model.load(examples_folder/"minepump.json")
  end

  extend(self)
end

RSpec.configure do |c|
  c.include Helpers
end
