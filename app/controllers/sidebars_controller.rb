# encoding: utf-8
class SidebarsController < ApplicationController
  before_filter :handle_unauthorized_request

  def edit
    @sidebar = Sidebar.the_only
    render :new
  end

  def update
    @sidebar = Sidebar.the_only

    if @sidebar.update_attributes(params[:sidebar])
      redirect_to home_path, :notice => "Sadržaj je uspješno izmjenjen."
    else
      render :new
    end
  end
end
