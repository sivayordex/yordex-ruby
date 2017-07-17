require_relative "../lib/yordex"
require "test/unit"

class YordexTest < Test::Unit::TestCase

    @@APIKEY = 'e4dc0992-1262-47b1-9090-464bbb4d0858'
    @@SUCCESS_ORDER = '45a108be-2e1a-4d08-b526-fb422090663f'
    @@FAILURE_ORDER = 'FAILURE!-2e1a-4d08-b526-fb422090663f'

  #Story 2: get a single order
    def test_successfully_request_a_single_order
      yordex = Yordex.new(@@APIKEY)
      yordex.useDevMode()
      order = yordex.get_order(@@SUCCESS_ORDER)
      assert_equal("200", order.code)
    end
    def test_unsuccessfully_request_a_single_order
      yordex = Yordex.new(@@APIKEY)
      yordex.useDevMode()
      order = yordex.get_order(@@FAILURE_ORDER)
      assert_not_equal("200", order.code)
    end

  #Story 3: create a traderId
  def test_successfully_create_trader
    yordex = Yordex.new(@@APIKEY)
    yordex.useDevMode()
    trader = yordex.create_trader(nil, 'email'+Random.rand(999999999).to_s+'@server'+Random.rand(999999999).to_s+'.com', 'asdASD12312432', 'Some company', '123 Street', 'London', 'GB', 'AAA1 1AA')
    assert_equal("201", trader.code)
    # "{\"companyTradingName\":\"Some company\",\"companyTradingAddress\":{\"address1\":\"123 Street\",\"postalCode\":\"AAA1 1AA\",\"city\":\"London\",\"countryCode\":\"GB\"},\"traderStatus\":\"REGISTERED\",\"id\":\"f508765a-dde9-46bb-a6f3-8f6ebe9ee7d8\"}"
  end
  def test_unsuccessfully_create_trader
    yordex = Yordex.new(@@APIKEY)
    yordex.useDevMode()
    trader = yordex.create_trader(nil, 'email'+Random.rand(999999999).to_s+'@server'+Random.rand(999999999).to_s+'.com', 'notavalidpassword', 'Some company', '123 Street', 'London', 'GB', 'AAA1 1AA')
    assert_not_equal("201", trader.code)
  end
  def test_successfully_update_trader
    yordex = Yordex.new(@@APIKEY)
    yordex.useDevMode()
    trader = yordex.create_trader(nil, 'email'+Random.rand(999999999).to_s+'@server'+Random.rand(999999999).to_s+'.com', 'asdASD12312432', 'Some company', '123 Street', 'London', 'GB', 'AAA1 1AA')
    # assert_equal("201", trader.code)
    res = JSON.parse(trader.body)

    update_trader = yordex.update_trader(res['id'], "Some company", "Some address", "Some city", "GB", "AAAA2 2AA")
    assert_equal("200", update_trader.code)
  end
  def test_unsuccessfully_update_trader
    yordex = Yordex.new(@@APIKEY)
    yordex.useDevMode()
    trader = yordex.create_trader(nil, 'email'+Random.rand(999999999).to_s+'@server'+Random.rand(999999999).to_s+'.com', 'asdASD12312432', 'Some company', '123 Street', 'London', 'GB', 'AAA1 1AA')
    assert_equal("201", trader.code)

    update_trader = yordex.update_trader(trader.response.id, "Some company", "Some address", "Some city", "GB", "AAAA2 2AA")
    assert_not_equal("201", trader.code)
  end

  # #Story 4: create and update order
  def test_successfully_create_order
    yordex = Yordex.new(@@APIKEY)
    yordex.useDevMode()
    order = yordex.create_order("ca4a3471-a33a-495d-b314-0c7cd1a9d31b", "61b71ad3-c168-4bf8-894b-634057a3287d", "Ruby Gem Order Test", 100000, "USD", "30% upfront 70% before shipping")

    assert_equal("201", order.code)
  end
  def test_unsuccessfully_create_order
    yordex = Yordex.new(@@APIKEY)
    yordex.useDevMode()
    order = yordex.create_order("ca4a3471-a33a-495d-b314-0c7cd1a9d31b", "not_valid", "Ruby Gem Order Test", 100000, "USD", "30% upfront 70% before shipping")

    assert_not_equal("201", order.code)
  end
  def test_successfully_update_order
    yordex = Yordex.new(@@APIKEY)
    yordex.useDevMode()
    order = yordex.create_order("ca4a3471-a33a-495d-b314-0c7cd1a9d31b", "61b71ad3-c168-4bf8-894b-634057a3287d", "Ruby Gem Order Test", 100000, "USD", "30% upfront 70% before shipping")

    res = JSON.parse(order.body)

    order_update = yordex.update_order(res["id"], "ca4a3471-a33a-495d-b314-0c7cd1a9d31b", "61b71ad3-c168-4bf8-894b-634057a3287d", "Ruby Gem Order Update Test", 100000, "USD", "30% upfront 70% before shipping")
    assert_not_equal("422", order_update.code)
    p order_update.code
  end
  def test_unsuccessfully_update_order
    yordex = Yordex.new(@@APIKEY)
    yordex.useDevMode()
    order = yordex.create_order("ca4a3471-a33a-495d-b314-0c7cd1a9d31b", "61b71ad3-c168-4bf8-894b-634057a3287d", "Ruby Gem Order Test", 100000, "USD", "30% upfront 70% before shipping")

    res = JSON.parse(order.body)

    order_update = yordex.update_order(res["id"], "ca4a3471-a33a-495d-b314-0c7cd1a9d31b", "not_valid", "Ruby Gem Order Update Test", 100000, "USD", "30% upfront 70% before shipping")
    assert_not_equal("201", order_update.code)
    p order_update.code
  end

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
