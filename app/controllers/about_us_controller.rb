class AboutUsController < ApplicationController
  def index
    @about_contents = GeneralContent.all
    @activities = Activity.order("year DESC")
    @members = Member.order(:last_name)
  end
end
