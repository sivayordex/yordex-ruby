class OrdersController < ApplicationController
  def index
  end

  def create
  end
  def create_do
    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()
    order = yordex.create_order(params[:buyer_id], params[:seller_id], params[:description], params[:order_amount_in_cents], params[:order_currency], params[:terms])

    @order = order
    @order_body = order.body
  end

  def get
  end
  def get_do
    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()
    order = yordex.get_order(params[:order_id])

    @order = order
    @order_body = order.body
  end

  def update
  end
  def update_do
    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()
    order = yordex.update_order(params[:order_id], params[:buyer_id], params[:seller_id], params[:description], params[:order_amount_in_cents], params[:order_currency], params[:terms])

    @order = order
    @order_body = order.body
  end

  def open
  end
  def open_do
    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()
    order = yordex.open_order(params[:order_id])

    @order = order
    @order_body = order.body
  end

  def close
  end
  def close_do
    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()
    order = yordex.close_order(params[:order_id])

    @order = order
    @order_body = order.body
  end
end
