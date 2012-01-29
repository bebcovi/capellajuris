class ActivitiesController < ApplicationController
  before_filter :only => [:new, :edit] do
    store_referer("#{about_us_path}#aktivnosti")
  end

  def preview
    @activity = Activity.new(params[:activity])
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.create(params[:activity])

    if @activity.valid?
      redirect_to referer
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
      redirect_to referer
    else
      render :new
    end
  end

  def destroy
    Activity.destroy(params[:id])
    redirect_to "#{about_us_path}#aktivnosti"
  end
end
