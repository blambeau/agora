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

  def minepump_model(kind = "json")
    Agora::Model.load(examples_folder/"minepump/minepump.#{kind}")
  end

  def fixture_model(kind = "kaos")
    Agora::Model.load(fixtures/"model.#{kind}")
  end

  extend(self)
end

RSpec.configure do |c|
  c.include Helpers
end
