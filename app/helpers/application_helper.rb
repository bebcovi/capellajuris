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

  def extended_form_for(object, options = {}, &block)
    options[:builder] = ExtendedFormBuilder
    form_for(object, options, &block)
  end

  def admin_logged_in?
    !!session[:admin_logged_in?]
  end

  def rework_photo(photo)
    parsed_photo = Nokogiri::HTML.parse(photo).at(:a)
    unless parsed_photo.nil?
      parsed_photo.tap do |link|
        link.delete("title") if link["title"] =~ /flickr/i
        link["class"] = "img"
      end.to_s
    else
      photo
    end
  end
end
