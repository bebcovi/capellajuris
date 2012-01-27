# encoding: utf-8
module ApplicationHelper
  def croatian_date(date)
    croatian_months = {
      1  => "siječnja",
      2  => "veljače",
      3  => "ožujka",
      4  => "travnja",
      5  => "svibnja",
      6  => "lipnja",
      7  => "srpnja",
      8  => "kolovoza",
      9  => "rujna",
      10 => "listopada",
      11 => "studenoga",
      12 => "prosinca"
    }

    "#{date.day}. #{croatian_months[date.month]}, #{date.year}"
  end

  def labeled_form_for(object, options = {}, &block)
    options[:builder] = LabeledFormBuilder
    form_for(object, options, &block)
  end

  def admin_logged_in?
    !!session[:admin_logged_in?]
  end

  def clear_flickr_photo(photo)
    Nokogiri::HTML.parse(photo).at(:a).tap do |link|
      link.delete("title")
      link["class"] = "img"
    end.to_s
  end
end
