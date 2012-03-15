class PagesController < ApplicationController
  around_filter :catch_flickr_timeouts, :only => :gallery

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
    @photos = Flickr.photos_from_set(admin[:flickr_set]).collect(&:medium640_or_less)
  end

  def videos
    @videos = Video.order(:id).page(params[:page]).per_page(3)
  end

  def archive
    @news = News.order("created_at DESC").page(params[:page]).per_page(10)
  end

  def delete_photo_cache
    FileUtils.rm_rf File.join(ENV["TMPDIR"], "juris-cache")
    redirect_to gallery_path
  end

private

  def catch_flickr_timeouts
    yield
  rescue Timeout::Error
    render "errors/flickr", :status => :gateway_timeout
  end
end
