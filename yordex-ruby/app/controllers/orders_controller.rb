class OrdersController < ApplicationController

  def set_nav
    section_nav_item =
      "<div><a href='/orders/create' class='#{request.path=='/orders/create' ? 'active' : ''}'>Create an Order</a></div>
      <div><a href='/orders/get' class='#{request.path=='/orders/get' ? 'active' : ''}'>Get an Order</a></div>
      <div><a href='/orders/update' class='#{request.path=='/orders/update' ? 'active' : ''}'>Update an Order</a></div>
      <div><a href='/orders/open' class='#{request.path=='/orders/open' ? 'active' : ''}'>Open an Order</a></div>
      <div><a href='/orders/close' class='#{request.path=='/orders/close' ? 'active' : ''}'>Close an Order</a></div>
      <div><a href='/orders/approve' class='#{request.path=='/orders/approve' ? 'active' : ''}'>Approve an Order</a></div>
      <div><a href='/orders/reject' class='#{request.path=='/orders/reject' ? 'active' : ''}'>Reject an Order</a></div>
      <div><a href='/orders/event' class='#{request.path=='/orders/event' ? 'active' : ''}'>Approve an Event</a></div>
      <div><a href='/orders/ads' class='#{request.path=='/orders/ads' ? 'active' : ''}'>Adverts</a></div>"
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
    order = yordex.create_order(params[:buyer_id], params[:seller_id], params[:description], params[:order_amount_in_cents], params[:order_currency], params[:terms])

    @order = order
    @order_body = order.body
  end

  def get
    @section_nav_item = set_nav()
  end
  def get_do
    @section_nav_item = set_nav()

    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()
    order = yordex.get_order(params[:order_id])

    @order = order
    @order_body = order.body
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
    order = yordex.update_order(params[:order_id], params[:buyer_id], params[:seller_id], params[:description], params[:order_amount_in_cents], params[:order_currency], params[:terms])

    @order = order
    @order_body = order.body
  end

  def open
    @section_nav_item = set_nav()
  end
  def open_do
    @section_nav_item = set_nav()

    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()
    order = yordex.open_order(params[:order_id])

    @order = order
    @order_body = order.body
  end

  def close
    @section_nav_item = set_nav()
  end
  def close_do
    @section_nav_item = set_nav()

    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()
    order = yordex.close_order(params[:order_id])

    @order = order
    @order_body = order.body
  end

  def approve
    @section_nav_item = set_nav()
  end
  def approve_do
    @section_nav_item = set_nav()

    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()
    order = yordex.approve_order(params[:order_id])

    @order = order
    @order_body = order.body
  end

  def reject
    @section_nav_item = set_nav()
  end
  def reject_do
    @section_nav_item = set_nav()

    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()
    order = yordex.reject_order(params[:order_id])

    @order = order
    @order_body = order.body
  end

  def event
    @section_nav_item = set_nav()
  end
  def event_do
    @section_nav_item = set_nav()

    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()
    event = yordex.confirm_event(params[:order_id], params[:event_id])

    @event = event
    @event_body = event.body
  end

  def ads
    @section_nav_item = set_nav()
  end
  def ads_do
    @section_nav_item = set_nav()

    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()
    ads = yordex.request_advertisements(params[:order_id])

    @ads = ads
    @ads_body = ads.body
  end
end
