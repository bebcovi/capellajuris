class HomeController < ApplicationController
  def index
    @intro, @sidebar = GeneralContent.first, Home.get_sidebar
    @news = News.order("created_at DESC")
  end
end
