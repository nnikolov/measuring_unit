require 'test_helper'

class CoreExtTest < ActiveSupport::TestCase
  def test_to_unit
    assert_equal "25\"1/2", "25 1/2".to_unit
  end
end
