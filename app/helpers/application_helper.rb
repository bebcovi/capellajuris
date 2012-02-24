# encoding: utf-8
module ApplicationHelper
  def login_or_logout_link
    if admin_logged_in?
      link_to "Odjava", logout_path, :method => :delete
    else
      link_to "Prijava administratora", login_path
    end
  end

  def navigation_pages
    [{:link => home_path, :name => "Početna"},
     {:link => about_us_path, :name => "O nama"},
     {:link => gallery_path, :name => "Slike"},
     {:link => videos_path, :name => "Video"}]
  end

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

  def rework_photo(photo)
    parsed_photo = Nokogiri::HTML.parse(photo).at(:a)
    unless parsed_photo.nil?
      cleaned_photo = parsed_photo.tap do |link|
        link.delete("title") if link["title"] =~ /flickr/i
        link["class"] = "img"
      end
      cleaned_photo.to_s.html_safe
    else
      photo
    end
  end

  def add_button(text, path, options = {})
    opt = {:class => 'new'}
    link_to text, path, opt.merge(options)
  end

  def edit_button(text, path, options = {})
    opt = {:class => 'edit'}
    link_to text, path, opt.merge(options)
  end

  def delete_button(text, path, options = {})
    opt = {:method => :delete, :confirm => "Jeste li sigurni?", :class => 'delete'}
    link_to text, path, opt.merge(options)
  end

  def cancel_button(text, path, options = {})
    opt = {:class => 'cancel'}
    link_to text, path, opt.merge(options)
  end

  def render_markdown(text)
    Redcarpet.new(text).to_html.html_safe
  end

  def audio_tag(sources, options = {})
    options.symbolize_keys!

    if sources.is_a?(Array)
      content_tag("audio", options) do
        sources.collect { |source| tag("source", :src => path_to_audio(source)) }.join.html_safe
      end
    else
      options[:src] = path_to_audio(sources)
      tag("audio", options)
    end
  end

  def labeled_form_for(object, options = {}, &block)
    options[:builder] = LabeledFormBuilder
    form_for(object, options, &block)
  end

  def extended_form_for(object, options = {}, &block)
    options[:builder] = ExtendedFormBuilder
    form_for(object, options, &block)
  end
end
