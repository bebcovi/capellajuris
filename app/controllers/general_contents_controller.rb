# encoding: utf-8
class GeneralContentsController < ApplicationController
  before_filter :authorize
  before_filter :store_referer, :only => :edit

  def preview
    @general_content = GeneralContent.new(params[:general_content])
  end

  def edit
    @general_content = GeneralContent.find(params[:id])
    render :new
  end

  def update
    @general_content = GeneralContent.find(params[:id])

    if @general_content.update_attributes(params[:general_content])
      redirect_to referer, :notice => "Sadržaj je uspješno izmjenjen."
    else
      render :new
    end
  end
end
