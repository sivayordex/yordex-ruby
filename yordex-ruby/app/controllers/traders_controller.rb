class TradersController < ApplicationController

  def set_nav
    section_nav_item =
      "<div><a href='/yordex-ruby/traders/create' class='#{request.path.start_with?('/yordex-ruby/traders/create') ? 'active' : ''}'>Create a Trader</a></div>
      <div><a href='/yordex-ruby/traders/update' class='#{request.path.start_with?('/yordex-ruby/traders/update') ? 'active' : ''}'>Update a Trader</a></div>"
  end

  def index
    @section_nav_item = set_nav()
  end

  def create
    @section_nav_item = set_nav()
  end
  def create_do
    @section_nav_item = set_nav()

    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()

    _trader_id = params[:trader_id]=="" || params[:trader_id]=="nil" ? nil : params[:trader_id]

    trader = yordex.create_trader(_trader_id, params[:email], params[:password], params[:company_name], params[:company_address_1], params[:company_city], params[:company_country_code], params[:company_postal_code])

    @trader = trader
    @trader_body = trader.body
  end

  def update
    @section_nav_item = set_nav()
  end
  def update_do
    @section_nav_item = set_nav()

    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()

    trader = yordex.update_trader(params[:trader_id], params[:company_name], params[:company_address_1], params[:company_city], params[:company_country_code], params[:company_postal_code])

    @trader = trader
    @trader_body = trader.body
  end

end
