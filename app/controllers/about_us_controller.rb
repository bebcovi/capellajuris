class AboutUsController < ApplicationController
  def index
    @about_us_contents = AboutUsContent.order(:content_order).collect do |content|
      case content.content_type
      when "general_content"
        {:type => "general_content", :object => GeneralContent.find(content.content_id)}
      when "members"
        {:type => "members", :object => Member.order(:last_name)}
      when "activities"
        {:type => "activities", :object => Activity.order("year DESC")}
      end
    end
  end
end
