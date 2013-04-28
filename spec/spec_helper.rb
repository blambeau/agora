$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'agora'

module Helpers

  def fixtures
    Path.dir/"fixtures"
  end

  def examples
    Path.backfind("examples").glob("*.json")
  end

  extend(self)
end

RSpec.configure do |c|
  c.include Helpers
end
