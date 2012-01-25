class HomeController < ApplicationController
  def index
    @intro = Intro.new
    @sidebar = Sidebar.new
    @news = News.order("created_at DESC")
  end
end
