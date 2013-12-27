require 'minitest_helper'

class TestRequestLogger < MiniTest::Unit::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::RequestLogger::VERSION
  end
end
