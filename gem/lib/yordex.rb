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

  def master_http(url, method, headers, body=nil)
    uri = URI.parse(url)
    printOrLog(url)
    http = Net::HTTP.new(uri.host, uri.port)
    if @@prod==true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.use_ssl = true
    end
    http.start

    if (method=="get")
      request = Net::HTTP::Get.new(uri.request_uri, headers)
    elsif (method=="post")
      request = Net::HTTP::Post.new(uri.request_uri, headers)
    elsif (method=="put")
      request = Net::HTTP::Put.new(uri.request_uri, headers)
    elsif (method=="delete")
      request = Net::HTTP::Delete.new(uri.request_uri, headers)
    end

    if (!body.blank?)
      request.body = body.to_json
    end

    response = http.request(request)

    return response
  end

  def get_order(order_id)
    return master_http(@@api_base+"/orders/#{order_id}", "get", {'Authorization'=>@@api_key})
  end

  def create_trader(trader_id, email, password, company_name, company_address_1, company_city, company_country_code, company_postal_code)
    return master_http(@@api_base+"/traders", "post", {'Authorization'=>@@api_key, 'Content-type'=>'application/json', 'Accept'=>'application/json'}, {
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
                  })
  end

  def update_trader(trader_id, company_name, address_1, city, country_code, postal_code)
    return master_http(@@api_base+"/traders/"+trader_id, "put", {'Authorization'=>@@api_key, 'Content-type'=>'application/json', 'Accept'=>'application/json'}, {
                    "companyTradingName"=>company_name,
                    "companyTradingAddress"=> {
                      "address1"=>address_1,
                      "city"=>city,
                      "countryCode"=>country_code,
                      "postalCode"=>postal_code
                    }
                  })
  end

  def create_order(buyer_id, seller_id, description, order_amount_in_cents, order_currency, terms)
    return master_http(@@api_base+"/orders", "post", {'Authorization'=>@@api_key, 'Content-type'=>'application/json'}, {
                    "buyerId"=>buyer_id,
                    "sellerId"=>seller_id,
                    "description"=>description,
                    "orderAmountInCents"=>order_amount_in_cents,
                    "orderCurrency"=>order_currency,
                    "terms"=>terms
                  })
  end

  def update_order(order_id, buyer_id, seller_id, description, order_amount_in_cents, order_currency, terms)
    return master_http(@@api_base+"/orders/"+order_id, "put", {'Authorization'=>@@api_key, 'Content-type'=>'application/json'}, {
                    "buyerId"=>buyer_id,
                    "sellerId"=>seller_id,
                    "description"=>description,
                    "orderAmountInCents"=>order_amount_in_cents,
                    "orderCurrency"=>order_currency,
                    "terms"=>terms
                  })
  end

  def open_order(order_id)
    return master_http(@@api_base+"/orders/"+order_id+"/open", "post", {'Authorization'=>@@api_key})
  end

  def close_order(order_id)
    return master_http(@@api_base+"/orders/"+order_id+"/close", "post", {'Authorization'=>@@api_key})
  end

  def approve_order(order_id)
    return master_http(@@api_base+"/orders/"+order_id+"/approvals", "post", {'Authorization'=>@@api_key, 'Content-type'=>'application/json'}, {
                      "approved"=>true
                  })
  end

  def reject_order(order_id)
    return master_http(@@api_base+"/orders/"+order_id+"/approvals", "post", {'Authorization'=>@@api_key, 'Content-type'=>'application/json'}, {
                      "approved"=>false
                  })
  end

  def request_advertisements(order_id)
    return master_http(@@api_base+"/ads?orderId="+order_id, "get", {'Authorization'=>@@api_key})
  end

  def enable_advertisement(url)
    return master_http(url, "post", {'Authorization'=>@@api_key})
  end

  def disable_advertisement(url)
    return master_http(url, "delete", {'Authorization'=>@@api_key})
  end

  def confirm_event(order_id, event_id)
    return master_http(@@api_base+"/orders/"+order_id+"/events/"+event_id+"/confirmations", "post", {'Authorization'=>@@api_key})
  end

  def get_sso_token(uri="/orders/order-id", redirect_url="your-redirect-url")
    return master_http(@@api_base+"/ssotokens", "post", {'Authorization'=>@@api_key, 'Content-type'=>'application/json'}, {
                    "uri"=>uri,
                    "redirectURL"=>redirect_url
                  })
  end


end
