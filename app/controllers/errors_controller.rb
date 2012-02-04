class ErrorsController < ApplicationController
  def not_found
    render "404"
  end

  def system_error
    render "500"
  end
end
