class Yordex

  require 'net/https'
  require 'json'

  # @@api_base = 'https://api.yordex.com/v1'
  @@api_base = 'http://api.dev.yordex.com'
  @@api_key = 'your-api-key'
  @@api_timeout = 61
  @@prod = false

  def initialize(api_key)
    @@api_key = api_key
  end

  def get_order(order_id)
    uri = URI.parse(@@api_base+"/orders/#{order_id}")
    p @@api_base+"/orders/#{order_id}"
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::Get.new(uri.request_uri, {'Authorization'=>@@api_key})
    response = http.request(request)

    return response
  end

  def create_trader(trader_id)
    uri = URI.parse(@@api_base+"/traders")
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::Post.new(uri.request_uri, {'Authorization'=>@@api_key, 'Content-type'=>'application/json', 'Accept'=>'application/json'})
    request.body = {
                      "traderId"=>trader_id,
                      "user" =>{
                          "email"=>"user@email.com",
                      },
                      "companyTradingName"=>"Company name",
                      "companyTradingAddress"=> {
                        "address1"=>"Address Line 1",
                        "city"=>"City",
                        "countryCode"=>"US",
                        "postalCode"=>"12345"
                      }
                  }.to_json
    response = http.request(request)

    return response
  end

  def update_trader
    uri = URI.parse(@@api_base+"/traders/trader-id")
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::Put.new(uri.request_uri, {'Authorization'=>@@api_key, 'Content-type'=>'application/json', 'Accept'=>'application/json'})
    request.body = {
                    "companyTradingName"=>"Company name",
                    "companyTradingAddress"=> {
                      "address1"=>"Address Line 1",
                      "city"=>"City",
                      "countryCode"=>"US",
                      "postalCode"=>"12345"
                    }
                  }.to_json
    response = http.request(request)

    return response
  end

  def create_order
    uri = URI.parse(@@api_base+"/orders")
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::Post.new(uri.request_uri, {'Authorization'=>@@api_key, 'Content-type'=>'application/json'})
    request.body = {
                    "buyerId"=>"other-trader-id",
                    "sellerId"=>"your-trader-id",
                    "description"=>"My first order",
                    "orderAmountInCents"=>100000,
                    "orderCurrency"=>"USD",
                    "terms"=>"30% upfront 70% before shipping"
                  }.to_json
    response = http.request(request)

    return response
  end

  def update_order
    uri = URI.parse(@@api_base+"/orders/order-id")
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::Put.new(uri.request_uri, {'Authorization'=>@@api_key, 'Content-type'=>'application/json'})
    request.body = {
                    "buyerId"=>"other-trader-id",
                    "sellerId"=>"your-trader-id",
                    "description"=>"My first order",
                    "orderAmountInCents"=>100000,
                    "orderCurrency"=>"USD",
                    "terms"=>"30% upfront 70% before shipping"
                  }.to_json
    response = http.request(request)

    return response
  end

  def open_order
    uri = URI.parse(@@api_base+"/orders/order-id/open")
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::POST.new(uri.request_uri, {'Authorization'=>@@api_key})
    response = http.request(request)

    return response
  end

  def close_order
    uri = URI.parse(@@api_base+"/orders/order-id/close")
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::POST.new(uri.request_uri, {'Authorization'=>@@api_key})
    response = http.request(request)

    return response
  end

  def approve_order
    uri = URI.parse(@@api_base+"/orders/order-id/approvals")
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::Post.new(uri.request_uri, {'Authorization'=>@@api_key, 'Content-type'=>'application/json'})
    request.body = {
                      "approved"=>true
                  }.to_json
    response = http.request(request)

    return response
  end

  def reject_order
    uri = URI.parse(@@api_base+"/orders/order-id/approvals")
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::Post.new(uri.request_uri, {'Authorization'=>@@api_key, 'Content-type'=>'application/json'})
    request.body = {
                      "approved"=>false
                  }.to_json
    response = http.request(request)

    return response
  end

  def request_advertisements
    uri = URI.parse(@@api_base+"/ads?orderId=order-id")
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::Get.new(uri.request_uri, {'Authorization'=>@@api_key})
    response = http.request(request)

    return response
  end

  def enable_advertisement

  end

    #Story 8: enable/disable advertisements
    # https://docs.yordex.com/docs/adding-services
    #
    # Scenario: successfully request enablement or disablement of an advertisement
    # Scenario: unsuccessfully request enablement or disablement of an advertisement
    # Scenario: successfully enable or disable an advertisement
    # Scenario: unsuccessfully enable or disable an advertisement

  def confirm_event
    uri = URI.parse(@@api_base+"/orders/order-id/events/event-id/confirmations")
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::Post.new(uri.request_uri, {'Authorization'=>@@api_key})
    response = http.request(request)

    return response
  end

  def get_sso_token
    uri = URI.parse(@@api_base+"/ssotokens  ")
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::Post.new(uri.request_uri, {'Authorization'=>@@api_key, 'Content-type'=>'application/json'})
    request.body = {
                    "uri"=>"/orders/order-id",
                    "redirectURL"=>"your-redirect-url"
                  }.to_json
    response = http.request(request)

    return response
  end


end
