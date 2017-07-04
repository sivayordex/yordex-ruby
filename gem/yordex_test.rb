require_relative "yordex"
require "test/unit"

class YordexTest < Test::Unit::TestCase

  #Story 2: get a single order

    # Scenario: successfully request a single order
    def test_successfully_request_a_single_order
      yordex = Yordex.new('some-key')
      order = yordex.get_order('order-id')
      assert_equal(200, order.code)
    end

    # Scenario: unsuccessfully request a single order
    def test_unsuccessfully_request_a_single_order
      yordex = Yordex.new('some-key')
      order = yordex.get_order('order-id')
      assert_not_equal(200, order.code)
    end

    # Scenario: successfully display a single order
    # Scenario: unsuccessfully display a single order

end