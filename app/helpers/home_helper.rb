# encoding: utf-8
module HomeHelper
  def render_markdown(text)
    Redcarpet.new(text).to_html
  end

  def navigation_pages
    [{:link => home_path, :name => "Početna"},
     {:link => about_us_path, :name => "O nama"},
     {:link => gallery_path, :name => "Slike"},
     {:link => videos_path, :name => "Video"}]
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
end
