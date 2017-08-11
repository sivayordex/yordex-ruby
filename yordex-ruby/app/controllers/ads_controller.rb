class AdsController < ApplicationController

  def set_nav
    section_nav_item =
      "<div><a href='/yordex-ruby/ads/get' class='#{request.path.start_with?('/yordex-ruby/ads/get') ? 'active' : ''}'>Get Advertisement</a></div>
      <div><a href='/yordex-ruby/ads/enable' class='#{request.path=='/yordex-ruby/ads/enable' ? 'active' : ''}'>Enable Advertisement</a></div>
      <div><a href='/yordex-ruby/ads/disable' class='#{request.path=='/yordex-ruby/ads/disable' ? 'active' : ''}'>Disable Advertisement</a></div>"
  end

  def index
    @section_nav_item = set_nav()
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
    ads = yordex.request_advertisements(params[:order_id])

    @ads = ads
    @ads_body = ads.body
  end

  def enable
    @section_nav_item = set_nav()
  end
  def enable_do
    @section_nav_item = set_nav()

    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()
    ads = yordex.enable_advertisement(params[:url])

    @ads = ads
    @ads_body = ads.body
  end

  def disable
    @section_nav_item = set_nav()
  end
  def disable_do
    @section_nav_item = set_nav()

    yordex = Yordex.new(session[:apikey])
    yordex.useDevMode()
    yordex.useDebug()
    yordex.usePrint()
    ads = yordex.disable_advertisement(params[:url])

    @ads = ads
    @ads_body = ads.body
    @ads_code = ads.code
  end
end
