class ErrorsController < ApplicationController
  def not_found
    render "404", :status => 404
  end

  def fake_401
    render "401"
  end

  def fake_404
    render "404"
  end

  def fake_500
    render "500"
  end
end
