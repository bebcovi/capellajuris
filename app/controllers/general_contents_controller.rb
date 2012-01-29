class GeneralContentsController < ApplicationController
  before_filter :handle_unauthorized_request

  before_filter :only => :edit do
    ids = GeneralContent.pluck(:id).sort
    case params[:id].to_i
    when ids.first
      store_referer("#{home_path}#intro")
    when ids.second
      store_referer("#{about_us_path}#povijest")
    when ids.third
      store_referer("#{about_us_path}#jurica")
    end
  end

  def edit
    @general_content = GeneralContent.find(params[:id])
    render :new
  end

  def update
    @general_content = GeneralContent.find(params[:id])

    if @general_content.update_attributes(params[:general_content])
      redirect_to referer
    else
      render :new
    end
  end
end
