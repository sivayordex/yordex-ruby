class SsoController < ApplicationController

  def set_nav
    section_nav_item =
      "<div><a href='/yordex-ruby/sso/get' class='#{request.path.start_with?('/yordex-ruby/sso/get') ? 'active' : ''}'>Get SSO</a></div>"
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

    sso = yordex.get_sso_token(params[:uri], params[:redirect_url])

    @sso = sso
    @sso_body = sso.body
  end
end
