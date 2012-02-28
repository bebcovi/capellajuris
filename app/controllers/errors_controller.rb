class ErrorsController < ApplicationController
  def not_found
    render "404", :status => 404
  end

  def internal_server_error
    render "500", :status => 500
  end
end
