class NewsController < ApplicationController
  before_filter :only => [:new, :edit] do
    store_referer("#{home_path}#vijesti")
  end

  def preview
    @news = News.new(params[:news])
  end

  def new
    @news = News.new
  end

  def create
    @news = News.create(params[:news])

    if @news.valid?
      redirect_to referer
    else
      render :new
    end
  end

  def edit
    @news = News.find(params[:id])
    render :new
  end

  def update
    @news = News.find(params[:id])

    if @news.update_attributes(params[:news])
      redirect_to referer
    else
      render :new
    end
  end

  def destroy
    News.destroy(params[:id])
    redirect_to "#{home_path}#vijesti"
  end
end
