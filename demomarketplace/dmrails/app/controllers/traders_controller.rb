class TradersController < ApplicationController
  def index
  end

  def create
  end
  def create_do
    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()

    _trader_id = params[:trader_id]=="" ? nil : params[:trader_id]

    trader = yordex.create_trader(_trader_id, params[:email], params[:password], params[:company_name], params[:company_address_1], params[:company_city], params[:company_country_code], params[:company_postal_code])

    @trader = trader
    @trader_body = trader.body
  end

  def update
  end
  def update_do
    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()

    trader = yordex.update_trader(params[:trader_id], params[:company_name], params[:address_1], params[:city], params[:country_code], params[:postal_code])

    @trader = trader
    @trader_body = trader.body
  end

end
