class HomeController < ApplicationController
  def index
    @intro, @sidebar = Home.get_intro, Home.get_sidebar
    @news = News.order("created_at DESC")
  end
end
