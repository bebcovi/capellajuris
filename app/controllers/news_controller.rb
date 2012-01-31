class NewsController < ApplicationController
  before_filter :handle_unauthorized_request

  before_filter :only => [:new, :edit] do
    store_referer(news_path)
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
      redirect_to news_path
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
      redirect_to news_path
    else
      render :new
    end
  end

  def destroy
    News.destroy(params[:id])
    redirect_to news_path
  end
end
