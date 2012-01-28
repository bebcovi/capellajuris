class AboutUsController < ApplicationController
  def index
    @about_us_content = GeneralContent.all
    @activities = Activity.order("year DESC")
    @members = Member.order(:last_name)
  end
end
