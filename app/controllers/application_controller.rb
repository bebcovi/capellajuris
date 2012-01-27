class ApplicationController < ActionController::Base
  protect_from_forgery

  def admin
    CapellaJuris::Application.config.admin
  end
end
