class Yordex

  require 'net/https'
  require 'json'
  require 'logger'

  @@api_base = 'https://api.yordex.com/v1'
  @@api_key = 'your-api-key'
  @@api_timeout = 61
  @@prod = false
  @@debug = false
  @@print = false

  def initialize(api_key)
    @@api_key = api_key
  end

  def useDevMode
    @@api_base = 'http://api.dev.yordex.com'
  end

  def useDebug
    @@debug = true
  end

  def usePrint
    @@print = true
  end

  def printOrLog(s)
    if @@print
      p s
    end
    if @@debug
      log = Logger.new(STDOUT)
      log.level = Logger::WARN
      log.debug(s)
    end
  end

  def get_order(order_id)
    uri = URI.parse(@@api_base+"/orders/#{order_id}")
    printOrLog(@@api_base+"/orders/#{order_id}")
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
    printOrLog(@@api_base+"/traders")
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
    printOrLog(@@api_base+"/traders/"+trader_id)
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

  def create_order(buyer_id, seller_id, description, order_amount_in_cents, order_currency, terms)
    uri = URI.parse(@@api_base+"/orders")
    printOrLog(@@api_base+"/orders")
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::Post.new(uri.request_uri, {'Authorization'=>@@api_key, 'Content-type'=>'application/json'})
    request.body = {
                    "buyerId"=>buyer_id,
                    "sellerId"=>seller_id,
                    "description"=>description,
                    "orderAmountInCents"=>order_amount_in_cents,
                    "orderCurrency"=>order_currency,
                    "terms"=>terms
                  }.to_json
    response = http.request(request)

    return response
  end

  def update_order(order_id, buyer_id, seller_id, description, order_amount_in_cents, order_currency, terms)
    uri = URI.parse(@@api_base+"/orders/"+order_id)
    printOrLog(@@api_base+"/orders/"+order_id)
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::Put.new(uri.request_uri, {'Authorization'=>@@api_key, 'Content-type'=>'application/json'})
    request.body = {
                    "buyerId"=>buyer_id,
                    "sellerId"=>seller_id,
                    "description"=>description,
                    "orderAmountInCents"=>order_amount_in_cents,
                    "orderCurrency"=>order_currency,
                    "terms"=>terms
                  }.to_json
    response = http.request(request)

    return response
  end

  def open_order(order_id)
    uri = URI.parse(@@api_base+"/orders/"+order_id+"/open")
    printOrLog(@@api_base+"/orders/"+order_id+"/open")
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::POST.new(uri.request_uri, {'Authorization'=>@@api_key})
    response = http.request(request)

    return response
  end

  def close_order(order_id)
    uri = URI.parse(@@api_base+"/orders/"+order_id+"/close")
    printOrLog(@@api_base+"/orders/"+order_id+"/close")
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::POST.new(uri.request_uri, {'Authorization'=>@@api_key})
    response = http.request(request)

    return response
  end

  def approve_order(order_id)
    uri = URI.parse(@@api_base+"/orders/"+order_id+"/approvals")
    printOrLog(@@api_base+"/orders/"+order_id+"/approvals")
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

  def reject_order(order_id)
    uri = URI.parse(@@api_base+"/orders/"+order_id+"/approvals")
    printOrLog(@@api_base+"/orders/"+order_id+"/approvals")
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

  def request_advertisements(order_id)
    uri = URI.parse(@@api_base+"/ads?orderId="+order_id)
    printOrLog(@@api_base+"/ads?orderId="+order_id)
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

  def confirm_event(order_id, event_id)
    uri = URI.parse(@@api_base+"/orders/"+order_id+"/events/"+event_id+"/confirmations")
    printOrLog(@@api_base+"/orders/"+order_id+"/events/"+event_id+"/confirmations")
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::Post.new(uri.request_uri, {'Authorization'=>@@api_key})
    response = http.request(request)

    return response
  end

  def get_sso_token(uri="/orders/order-id", redirect_url="your-redirect-url")
    uri = URI.parse(@@api_base+"/ssotokens")
    printOrLog(@@api_base+"/ssotokens")
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.use_ssl = true
    end
    http.start
    request = Net::HTTP::Post.new(uri.request_uri, {'Authorization'=>@@api_key, 'Content-type'=>'application/json'})
    request.body = {
                    "uri"=>uri,
                    "redirectURL"=>redirect_url
                  }.to_json
    response = http.request(request)

    return response
  end


end
