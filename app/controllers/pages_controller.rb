class PagesController < ApplicationController
  def index
    @intro, @sidebar = GeneralContent.first, Sidebar.the_only
    @news = News.order("created_at DESC").limit(5)
  end

  def about_us
    @history, @conductor = GeneralContent.last(2)
    @activities = Activity.order("year DESC")
    @members = Member.order(:last_name)
  end

  def gallery
    @photos = Flickr.photos_from_set(admin[:flickr_set]).collect(&:largest)
  end

  def videos
    @videos = Video.order(:id)
  end

  def archive
    @news = News.order("created_at DESC").page(params[:page]).per_page(10)
  end
end
