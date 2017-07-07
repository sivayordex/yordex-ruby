class Yordex

  require 'net/https'
  require 'json'

  @api_base = 'https://api.yordex.com/v1/'
  @api_key = 'your-api-key'

  def initialize(api_key)
    @api_key = api_key
  end

  def get_api_key(user, pass)
    uri = URI.parse("http://internal-api.dev.yordex.com/sessions")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.start
    request = Net::HTTP::Get.new(uri.request_uri, {'Authorization'=>'none', 'Content-Type'=>'application/json'})
    request.body = {username: user, password: pass}.to_json
    response = http.request(request)

    p response

    uri = URI.parse("http://internal-api.dev.yordex.com/api-keys")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.start
    request = Net::HTTP::Get.new(uri.request_uri, {'Authorization'=>response.token})
    response = http.request(request)

    p response
  end

  def get_order(order_id)
    uri = URI.parse("https://api.yordex.com/v1/orders/#{order_id}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.start
    request = Net::HTTP::Get.new(uri.request_uri, {'Authorization'=>@api_key})
    response = http.request(request)

    return response
  end





  #Story 3: create and update trader
  # https://docs.yordex.com/docs/creating-a-trader

  # Scenario: successfully request creation of a new trader
  # Scenario: successfully request update of a trader
  # Scenario: unsuccessfully request creation or update of a trader
  # Scenario: unsuccessfully request update of a trader without Trader ID
  # Scenario: successfully create a new trader
  # Scenario: successfully update a trader
  # Scenario: unsuccessfully create a new trader
  # Scenario: unsuccessfully update a trader

  #Story 4: create and update order
  # https://docs.yordex.com/docs/creating-an-order
  #
  # Scenario: successfully request creation of an order
  # Scenario: successfully request update of an order
  # Scenario: unsuccessfully request creation of an order
  # Scenario: unsuccessfully request update of an order without order ID
  # Scenario: successfully create a new order
  # Scenario: successfully update an order
  # Scenario: unsuccessfully create or update an order

  #Story 5: open and close an order
  # https://docs.yordex.com/docs/creating-an-order
  #
  # Scenario: successfully request closing or opening of an order
  # Scenario: unsuccessfully request closing or opening of an order without order ID
  # Scenario: successfully close or open an order
  # Scenario: unsuccessfully close or open an order

  #Story 6: approve order
  # https://docs.yordex.com/docs/approving-an-order
  #
  # Scenario: successfully request approval of an order
  # Scenario: successfully request rejection of an order
  # Scenario: unsuccessfully request approval or rejection of an order
  # Scenario: successfully approve or reject an order
  # Scenario: unsuccessfully approve or reject an order

  #Story 7: display advertisements
  # https://docs.yordex.com/docs/adding-services
  #
  # Scenario: successfully request advertisements
  # Scenario: unsuccessfully request advertisements
  # Scenario: successfully display advertisements
  # Scenario: inform user if there were no advertisements
  # Scenario: inform user if the advertisements API gave an error

  #Story 8: enable/disable advertisements
  # https://docs.yordex.com/docs/adding-services
  #
  # Scenario: successfully request enablement or disablement of an advertisement
  # Scenario: unsuccessfully request enablement or disablement of an advertisement
  # Scenario: successfully enable or disable an advertisement
  # Scenario: unsuccessfully enable or disable an advertisement

  #Story 9: confirming an event
  # https://docs.yordex.com/docs/confirming-an-event
  #
  # Scenario: successfully request confirmation of an event
  # Scenario: unsuccessfully request confirmation of an event
  # Scenario: successfully confirm an event
  # Scenario: unsuccessfully confirm an event

  #Story 10: get SSO token
  # https://docs.yordex.com/docs/single-sign-on
  #
  # Scenario: successfully request SSO token
  # Scenario: unsuccessfully request SSO token
  # Scenario: successfully display SSO token
  # Scenario: unsuccessfully display SSO token




  def makeRequst()
    url = URI.parse('http://www.example.com/index.html')
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    puts res.body
  end


end
