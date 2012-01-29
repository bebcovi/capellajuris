class AboutUsController < ApplicationController
  def index
    @history, @conductor = GeneralContent.last(2)
    @activities = Activity.order("year DESC")
    @members = Member.order(:last_name)
  end
end
