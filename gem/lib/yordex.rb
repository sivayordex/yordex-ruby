class Yordex

    require 'net/https'
    require 'json'
    require 'logger'

    @@api_base = 'https://api.yordex.com/v1'
    @@api_key = 'your-api-key'
    @@api_timeout = 61
    @@prod = false
    @@test = false
    @@debug = false
    @@print = false

    def initialize(api_key, env=nil)
        @@api_key = api_key
        if env == 'test'
            @@test = true
            @@api_base = 'https://api.test.yordex.com'
        elsif env == 'prod'
            @@prod = true
            @@api_base = 'https://api.yordex.com/v1'
        end
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

    def printOrLog(s) if @@print
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

    if @@test==true
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

    if (!body.nil? && !body.empty?)
        request.body = body.to_json
    end

    printOrLog(request.body)

    response = http.request(request)

    printOrLog(response.to_json)

    return response
  end

  def get_order(order_id)
    return master_http(@@api_base+"/orders/#{order_id}", "get", {'Authorization'=>@@api_key})
  end

  def create_trader(partner_id, email, password, company_name, company_address_1, company_city, company_country_code, company_postal_code)
    _json = if ((company_address_1.nil? || company_address_1.empty?) &&
                (company_city.nil? || company_city.empty?) &&
                (company_country_code.nil? || company_country_code.empty?) &&
                (company_postal_code.nil? || company_postal_code.empty?))
            then
              {
                "partnerId"=>partner_id,
                "user" =>{
                  "email"=>email,
                  "password"=>password
                },
                "companyTradingName"=>company_name
              }
            else
              {
                "partnerId"=>partner_id,
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
              }
            end

    return master_http(@@api_base+"/traders", "post",
                      {'Authorization'=>@@api_key, 'Content-type'=>'application/json', 'Accept'=>'application/json'}, _json)
  end

  def update_trader(trader_id, company_name, address_1, city, country_code, postal_code)
    _json = if ((address_1.nil? || address_1.empty?) &&
                (city.nil? || city.empty?) &&
                (country_code.nil? || country_code.empty?) &&
                (postal_code.nil? || postal_code.empty?))
            then
              {
                "companyTradingName"=>company_name
              }
            else
              {
                "companyTradingName"=>company_name,
                "companyTradingAddress"=> {
                  "address1"=>address_1,
                  "city"=>city,
                  "countryCode"=>country_code,
                  "postalCode"=>postal_code
                }
              }
            end

    return master_http(@@api_base+"/traders/"+trader_id, "put",
                      {'Authorization'=>@@api_key, 'Content-type'=>'application/json', 'Accept'=>'application/json'}, _json)
  end

  def create_order(buyer_id, seller_id, description, order_amount_in_cents, order_currency, terms)
    return master_http(@@api_base+"/orders", "post",
                      {'Authorization'=>@@api_key, 'Content-type'=>'application/json'},
                      {
                        "buyerId"=>buyer_id,
                        "sellerId"=>seller_id,
                        "description"=>description,
                        "orderAmountInCents"=>order_amount_in_cents,
                        "orderCurrency"=>order_currency,
                        "terms"=>terms
                      })
  end

  def update_order(order_id, buyer_id, seller_id, description, order_amount_in_cents, order_currency, terms)
    return master_http(@@api_base+"/orders/"+order_id, "put",
                      {'Authorization'=>@@api_key, 'Content-type'=>'application/json'},
                      {
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
    return master_http(@@api_base+"/orders/"+order_id+"/approvals", "post",
                      {'Authorization'=>@@api_key, 'Content-type'=>'application/json'},
                      {
                          "approved"=>true
                      })
  end

  def reject_order(order_id)
    return master_http(@@api_base+"/orders/"+order_id+"/approvals", "post",
                      {'Authorization'=>@@api_key, 'Content-type'=>'application/json'},
                      {
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
    return master_http(@@api_base+"/ssotokens", "post",
                      {'Authorization'=>@@api_key, 'Content-type'=>'application/json'},
                      {
                        "uri"=>uri,
                        "redirectUrl"=>redirect_url
                      })
  end


end
