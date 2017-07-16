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

  def create_trader(trader_id, email, password, company_name, company_address_1, company_city, company_country_code, company_postal_code)
    uri = URI.parse(@@api_base+"/traders")
    p @@api_base+"/traders"
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
                          "email"=>email,
                          "password"=>password
                      },
                      "companyTradingName"=>company_name,
                      "companyTradingAddress"=> {
                        "address1"=>company_address_1,
                        "city"=>company_city,
                        "countryCode"=>company_country_code,
                        "postalCode"=>company_postal_code
                      }
                  }.to_json
    response = http.request(request)

    return response
  end

  def update_trader(trader_id, company_name, address_1, city, country_code, postal_code)
    uri = URI.parse(@@api_base+"/traders/"+trader_id)
    p @@api_base+"/traders/"+trader_id
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::Put.new(uri.request_uri, {'Authorization'=>@@api_key, 'Content-type'=>'application/json', 'Accept'=>'application/json'})
    request.body = {
                    "companyTradingName"=>company_name,
                    "companyTradingAddress"=> {
                      "address1"=>address_1,
                      "city"=>city,
                      "countryCode"=>country_code,
                      "postalCode"=>postal_code
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
