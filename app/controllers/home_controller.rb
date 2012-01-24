class HomeController < ApplicationController
  def index
    @intro = Intro.first
    @news = News.order("created_at DESC")
  end
end
