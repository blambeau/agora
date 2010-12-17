require "test/unit"
require "agora"

class TestAgora < Test::Unit::TestCase

  def test_version
    assert_not_nil Agora::VERSION
  end

end
