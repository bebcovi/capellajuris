# encoding: UTF-8
class Content < ActiveRecord::Base
  before_create do
    self.order_no = self.class.by_page(page).maximum(:order_no).to_i + 1
  end

  def move(direction)
    delta = case direction
    when '▲' then -1
    when '▼' then 1
    end
    if other = on_same_page.find_by_order_no(order_no + delta)
      switch_positions(other)
    end
    return self
  end

  def switch_positions(other)
    self.order_no, other.order_no = other.order_no, self.order_no
    self.save
    other.save
  end

  def on_same_page
    self.class.by_page(page)
  end

  def self.by_page(page)
    where(:page => page)
  end
end

class Member < ActiveRecord::Base
  VOICES = {
    's' => 'soprani',
    'a' => 'alti',
    't' => 'tenori',
    'b' => 'basi'
  }

  def self.voices
    VOICES.values
  end

  def self.by_voice(name)
    where(:voice => VOICES.key(name).capitalize)
  end

  def self.voice_abbr(voice)
    VOICES.key(voice)
  end
end

class News < ActiveRecord::Base
  self.per_page = 10
end

class Page < ActiveRecord::Base
  before_validation do |page|
    page.haml_name = page.cro_name.underscorize
  end

  validates :haml_name,
    :exclusion => {:in => Dir['views/*.haml'].collect { |file| file.match(/([^\/]+)\.haml$/)[1] },
                   :message => 'Stranica s tim imenom već postoji.'}

  before_create :move_right_pages_forward, :create_haml_file

  def move_right_pages_forward
    self.order_no = self.class.find_by_haml_name('slike').order_no
    self.class.where("order_no >= ?", order_no).each { |page| page.increment!(:order_no) }
  end

  def create_haml_file
    File.open(File.join(settings.views, "#{haml_name}.haml"), 'w') do |file|
      file.puts "- @page_title = '#{cro_name}'\n"
      file.puts "- Content.by_page('/#{haml_name}').order(:order_no).each do |content|\n" \
                "  = render_partial content.content_type, locals: {content: content}\n"
      file.puts "- buttons({add: 'Dodaj +'}, '/content/new') if logged_in?"
    end
  end

  after_destroy do |page|
    self.class.where("order_no > ?", page.order_no).each { |page| page.decrement!(:order_no) }
    File.delete File.join(settings.views, "#{page.haml_name}.haml")
  end
end

class Sidebar < ActiveRecord::Base
  def video
    video = Hpricot(read_attribute(:video)).at(:iframe)
    video[:height], video[:width] = '180', '306'
    return video.to_html
  end
end

class User < ActiveRecord::Base
  attr_accessor :password

  def self.encrypt(password, password_salt)
    BCrypt::Engine.hash_secret(password, password_salt)
  end


  def self.authenticate(user_hash)
    if user = find_by_username(user_hash[:username])
      if user.password_hash == encrypt(user_hash[:password], user.password_salt)
        return user
      end
    end
  end

  before_create :encrypt_password

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = self.class.encrypt(password, password_salt)
  end
end

class Video < ActiveRecord::Base
end

class Audio < ActiveRecord::Base
  before_create do
    Audio.first.destroy if Audio.count == 5
  end

  def has_ogg?
    ogg
  end

  def ogg_filename
    uploaded_filename.sub(/\.\w{2,5}$/, '.ogg')
  end

  before_destroy :delete_audio_files

  def delete_audio_files
    original = File.expand_path "public/audio/#{uploaded_filename}"
    ogg = original.sub(/\.\w{2,5}$/, '.ogg')
    File.delete original
    File.delete ogg if File.exists? ogg
  end
end
