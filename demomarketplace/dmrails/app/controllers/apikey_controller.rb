class ApikeyController < ApplicationController
  def set
    session[:apikey] = params[:txtApiKey]
    redirect_to request.referrer
  end
end
