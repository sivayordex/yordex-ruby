require_relative "yordex"
require "test/unit"

class YordexTest < Test::Unit::TestCase

    @@APIKEY = '6bf88483-fcc4-4a77-8d19-201853f2df62'
    @@SUCCESS_ORDER = '26f210a7-ccc7-4d08-aaba-509ff4f4ad1e'
    @@FAILURE_ORDER = 'FAILURE!-ccc7-4d08-aaba-509ff4f4ad1e'
    # def test_get_api_key
    #   yordex = Yordex.new(nil)
    #   yordex.get_api_key('andrew@hsmoore.com', 'ASDqwe123')
    # end
  #
  #Story 2: get a single order
    #
    # Scenario: successfully request a single order
    def test_successfully_request_a_single_order
      yordex = Yordex.new(@@APIKEY)
      order = yordex.get_order(@@SUCCESS_ORDER)
      assert_equal(200, order.code)
    end

    # Scenario: unsuccessfully request a single order
    def test_unsuccessfully_request_a_single_order
      yordex = Yordex.new(@@APIKEY)
      order = yordex.get_order(@@FAILURE_ORDER)
      assert_not_equal(200, order.code)
    end
  #
  #   # Scenario: successfully display a single order
  #   # Scenario: unsuccessfully display a single order

  # #Story 3: create a traderId
  #   # Scenario: successfully request creation of a new trader
  # def test_create_trader
  #   yordex = Yordex.new(@@APIKEY)
  #   order = yordex.create_trader('my_trader_id')
  #   assert_equal(200, order.code)
  # end
  #   # Scenario: unsuccessfully request creation or update of a trader
  #   # Scenario: unsuccessfully request update of a trader without Trader ID
  #   # Scenario: successfully create a new trader
  #   # Scenario: successfully update a trader
  #   # Scenario: unsuccessfully create a new trader
  #   # Scenario: unsuccessfully update a trader

  # #Story 4: create and update order
  #   # Scenario: successfully request creation of an order
  #   # Scenario: successfully request update of an order
  #   # Scenario: unsuccessfully request creation of an order
  #   # Scenario: unsuccessfully request update of an order without order ID
  #   # Scenario: successfully create a new order
  #   # Scenario: successfully update an order
  #   # Scenario: unsuccessfully create or update an order

  # #Story 5: open and close an order
  #   # Scenario: successfully request closing or opening of an order
  #   # Scenario: unsuccessfully request closing or opening of an order without order ID
  #   # Scenario: successfully close or open an order
  #   # Scenario: unsuccessfully close or open an order

  # #Story 6: approve order
  #   # Scenario: successfully request approval of an order
  #   # Scenario: successfully request rejection of an order
  #   # Scenario: unsuccessfully request approval or rejection of an order
  #   # Scenario: successfully approve or reject an order
  #   # Scenario: unsuccessfully approve or reject an order

  # #Story 7: display advertisements
  #   # sScenario: successfully request advertisements
  #   # Scenario: unsuccessfully request advertisements
  #   # Scenario: successfully display advertisements
  #   # Scenario: inform user if there were no advertisements
  #   # Scenario: inform user if the advertisements API gave an error

  # #Story 8: enable/disable advertisements
  #   # Scenario: successfully request enablement or disablement of an advertisement
  #   # Scenario: unsuccessfully request enablement or disablement of an advertisement
  #   # Scenario: successfully enable or disable an advertisement
  #   # Scenario: unsuccessfully enable or disable an advertisement

  # #Story 9: confirming an event
  #   # Scenario: successfully request confirmation of an event
  #   # Scenario: unsuccessfully request confirmation of an event
  #   # Scenario: successfully confirm an event
  #   # Scenario: unsuccessfully confirm an event

  # #Story 10: get SSO token
  #   # Scenario: successfully request SSO token
  #   # Scenario: unsuccessfully request SSO token
  #   # Scenario: successfully display SSO token
  #   # Scenario: unsuccessfully display SSO token
end
