class ApplicationController < ActionController::Base
  protect_from_forgery

  def admin
    CapellaJuris::Application.config.admin
  end

  def store_referer(url = nil)
    if url
      session[:referer] = url
    else
      session[:referer] = request.referer
    end
  end

  def referer
    session[:referer] || home_path
  end
  helper_method :referer
end
