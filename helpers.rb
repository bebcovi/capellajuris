# encoding:utf-8
Pages = [
  {normal: 'index', croatian: 'Početna'},
  {normal: 'o_nama', croatian: 'O Nama'},
  {normal: 'slike', croatian: 'Slike'},
  {normal: 'video', croatian: 'Video'}
]

helpers do
  def current?(page)
    ('/' + page[:normal] == request.path_info) or (page[:normal] == 'index' and request.path_info == '/')
  end

  def auth?
    User[:username => params[:username], :password => params[:password]]
  end

  def login
    session[:logged] = true
  end

  def logout
    session[:logged] = false
  end

  def logged_in?
    session[:logged]
  end

  def voice_to_cro(voice)
    case voice
    when 'S'; 'Soprani'
    when 'A'; 'Alti'
    when 'T'; 'Tenori'
    when 'B'; 'Basi'
    end
  end
end

module Haml
  module Helpers
    def form_tag(attr, &block)
      if attr[:method] == 'get' or attr[:method] == 'post'
        haml_tag(:form,     { action: attr[:action],
                              method: attr[:method],
                              id: attr[:id]}) { yield }
      else
        haml_tag(:form,     { action: attr[:action],
                              method: 'post',
                              id: attr[:id]}) do

          haml_tag(:input,  { type: 'hidden',
                              name: '_method',
                              value: attr[:method]}) do
            yield
          end
        end
      end
    end

    def generate_posts
      Post.each do |post|
        haml_tag :article do
          haml_tag :header do
            haml_tag :hgroup do
              haml_tag :h1, post.title
              haml_tag :h2, post.subtitle
            end
            haml_tag :time, {datetime: post.created_at, :pubdate => true}, post.created_at.to_s(:cro)
          end
          post.body.split("\n").each do |paragraph|
            haml_tag :p, paragraph
          end

          if logged_in?
            form_tag(action: "/post/#{post.id}", method: 'get', id: 'edit') do
              haml_tag :input, {type: 'submit', value: 'Izmjeni'}
            end
            form_tag(action: "/delete/#{post.id}", method: 'delete', id: 'delete') do
              haml_tag :input, {type: 'submit', value: 'Izbriši'}
            end
          end
        end
      end

      if logged_in?
        form_tag(action: '/post/new', method: 'get', id: 'add') do
          haml_tag :input, {type: 'submit', value: 'Dodaj'}
        end
      end
    end

    def generate_members
      ['S','A','T','B'].each do |voice|
        haml_tag(:ul, {:class => 'members'}) do
          haml_tag(:li, {:class => 'first'}, voice_to_cro("#{voice}"))
          last = Member.filter(:voice => voice).count
          Member.filter(:voice => voice).order(:last_name).each_with_index do |member, index|
            haml_tag(:li, {:class => (index == last) && 'last'}, "#{member.first_name} #{member.last_name}")
          end
        end
      end
    end

    def generate_activities
      haml_tag :ol, {:class => 'activities', start: '2006'} do
        Article.each do |things|
          haml_tag :li do
            haml_tag :ol do
              things.split("\n").each do |list_element|
                haml_tag :li, list_element
              end
            end
          end
        end
      end
    end

    def generate_other_content
      case article.title
      when 'Povijest zbora'
        haml_tag :img, {:class => 'intext', src: 'images/povijest_zbora.jpg', alt: 'zbor', width: '250', height: '168'}
      when 'Biografija dirigenta'
        haml_tag :img, {:class => 'intext', src: 'images/biografija_dirigenta.jpg', alt: 'jurica petar petrač', width: '137', height: '168'}
      end
      article.body.split("\n").each do |paragraph|
        haml_tag :p, paragraph
      end
    end
  end
end
