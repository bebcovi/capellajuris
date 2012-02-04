# encoding: utf-8
class ActivitiesController < ApplicationController
  before_filter :handle_unauthorized_request
  before_filter :store_referer, :only => [:new, :edit]

  def preview
    @activity = Activity.new(params[:activity])
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.create(params[:activity])

    if @activity.valid?
      redirect_to about_us_path, :notice => "Nova godina aktivnosti je uspješno dodana."
    else
      render :new
    end
  end

  def edit
    @activity = Activity.find(params[:id])
    render :new
  end

  def update
    @activity = Activity.find(params[:id])

    if @activity.update_attributes(params[:activity])
      redirect_to about_us_path, :notice => "Aktivnosti su upješno izmjenjene."
    else
      render :new
    end
  end

  def destroy
    activity = Activity.destroy(params[:id])
    redirect_to about_us_path, :notice => "#{activity.year}. godina aktivnosti je izbrisana."
  end
end
