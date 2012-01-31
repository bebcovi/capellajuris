class SidebarsController < ApplicationController
  def edit
    @sidebar = Sidebar.the_only
    render :new
  end

  def update
    @sidebar = Sidebar.the_only

    if @sidebar.update_attributes(params[:sidebar])
      redirect_to intro_path
    else
      render :new
    end
  end
end
