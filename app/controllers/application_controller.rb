class ApplicationController < ActionController::Base
  protect_from_forgery

  def logged_in?
    true
  end
  helper_method :logged_in?
end
