# encoding:utf-8
helpers do
  def current?(page)
    '/' + page.haml_name == request.path_info
  end

  def form?(page)
    Dir['views/forms/*'].include? "views/forms/#{page}.haml"
  end

  def authenticate!(&block)
    if not User[:username => params[:username], :password => params[:password]]
      @error = 'Krivo korisničko ime ili lozinka.'
      haml "forms#{request.path_info}".to_sym
    else
      yield
    end
  end

  def log_in!
    session[:logged_in] = true
  end

  def log_out!
    session[:logged_in] = false
  end

  def logged_in?
    session[:logged_in]
  end

  def string_to_id(string)
    string.parameterize
  end

  def cancel_pressed?
    params[:action] == 'Odustani'
  end

  def error?(column)
    @content.errors.has_key?(column)
  end

  def form_tag(form_attr, &block)
    if form_attr[:method] == 'get' or form_attr[:method] == 'post'
      haml_tag(:form, form_attr) { yield if block_given? }
    else
      haml_tag(:form, form_attr.merge(method: 'post')) do
        haml_tag(:input, {type: 'hidden', name: '_method', value: form_attr[:method]}) do
          yield if block_given?
        end
      end
    end
  end

  def edit_button(link, value = 'Izmjeni')
    haml_tag :a, value, {:href => link, :class => 'edit'}
  end

  def delete_button(link, value = 'Izbriši')
    form_tag(:action => link, :method => 'delete') do
      haml_tag :input, {type: 'submit', value: value, :class => 'delete'}
    end
  end

  def add_button(link, value = 'Dodaj +')
    haml_tag :a, value, {:href => link, :class => 'add'}
  end

  def render_markdown(text)
    BlueCloth.new(text).to_html
  end
end

class Fleakr::Objects::Photo
  def get_sizes
    flickr.photos.getSizes(:photo_id => id).inject([]) do |sizes, element|
      sizes << element['label'].downcase.delete(' ')
    end
  end

  def get_sizes_and_info
    flickr.photos.getSizes(:photo_id => id)
  end

  alias medium500 medium

  def medium640
    unless (info = get_sizes_and_info[4]) == nil
      result = medium
      result.url = info['source']
      result.width = info['width']
      result.height = info['height']
      return result
    else
      return nil
    end
  end

  def largest
    original || large || medium640 || medium500 || small || thumbnail || square
  end
end


def flickr_photo_sizes
  ['square', 'thumbnail', 'small', 'medium', 'medium500', 'medium640', 'large', 'original']
end

def nearest_size(photo_size)
  if photo_size.split('x').first.match(/[^0-9]+/) == nil
    case photo_size.split('x').first.to_i
    when 1..75
      'square'
    when 76..100
      'thumbnail'
    when 101..240
      'small'
    when 241..500
      'medium'
    when 501..640
      'medium640'
    else
      'large'
    end
  else
    photo_size
  end
end

def string_to_method(string)
  string.downcase.delete(' ')
end
