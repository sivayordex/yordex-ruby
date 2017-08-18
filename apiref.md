HL-1129: https://docs.yordex.com/v1/reference#get-order
```
require "yordex"
yordex = Yordex.new('your-api-key')
begin
  order = yordex.get_order('order-id')
rescue => err
  p err
  # $!.message
  # $!.backtrace
end
```

HL-1130: https://docs.yordex.com/v1/reference#create-trader
```
require "yordex"
yordex = Yordex.new('your-api-key')
begin
  trader = yordex.create_trader(partner_id, email, password, company_name, company_address_1, company_city, company_country_code, company_postal_code)
rescue => err
  p err
  # $!.message
  # $!.backtrace
end
```

HL-1130: https://docs.yordex.com/v1/reference#update-trader
```
require "yordex"
yordex = Yordex.new('your-api-key')
begin
  trader = yordex.update_trader(trader_id, company_name, address_1, city, country_code, postal_code)
rescue => err
  p err
  # $!.message
  # $!.backtrace
end
```

HL-1131: https://docs.yordex.com/v1/reference#create-order
```
require "yordex"
yordex = Yordex.new('your-api-key')
begin
  order = yordex.create_order(buyer_id, seller_id, description, order_amount_in_cents, order_currency, terms)
rescue => err
  p err
  # $!.message
  # $!.backtrace
end
```

HL-1131: https://docs.yordex.com/v1/reference#update-order
```
require "yordex"
yordex = Yordex.new('your-api-key')
begin
  order = yordex.update_order(order_id, buyer_id, seller_id, description, order_amount_in_cents, order_currency, terms)
rescue => err
  p err
  # $!.message
  # $!.backtrace
end
```

HL-1132: https://docs.yordex.com/v1/reference#approve-order
```
require "yordex"
yordex = Yordex.new('your-api-key')
begin
  order = yordex.approve_order('order-id')
rescue => err
  p err
  # $!.message
  # $!.backtrace
end
```

HL-1133: https://docs.yordex.com/v1/reference#request-ads
```
require "yordex"
yordex = Yordex.new('your-api-key')
begin
  advert = yordex.request_advertisements('order-id')
rescue => err
  p err
  # $!.message
  # $!.backtrace
end
```

HL-1134: no sample code


HL-1135: https://docs.yordex.com/v1/reference#confirm-event
```
require "yordex"
yordex = Yordex.new('your-api-key')
begin
  event = yordex.confirm_event('order-id', 'event-id')
rescue => err
  p err
  # $!.message
  # $!.backtrace
end
```

HL-1136: https://docs.yordex.com/docs/single-sign-on
```
require "yordex"
yordex = Yordex.new('your-api-key')
begin
  token = yordex.get_sso_token(uri="/orders/order-id", redirect_url="your-redirect-url")
rescue => err
  p err
  # $!.message
  # $!.backtrace
end
```
