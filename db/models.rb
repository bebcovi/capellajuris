# encoding: UTF-8
class Content < ActiveRecord::Base
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

  before_create do
    unless order_no.present?
      self.order_no = Content.by_page(page).maximum(:order_no).to_i + 1
    end
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
    page.haml_name = Helpers.urlize(page.cro_name)
  end

  validates :haml_name,
    :exclusion => {:in => Dir['views/*.haml'].collect { |file| file.match(/([^\/]+)\.haml$/)[1] },
                   :message => 'Stranica s tim imenom već postoji.'}

  before_create do |page|
    page.order_no = page.class.find_by_haml_name('slike').order_no
    Page.where("order_no >= ?", page.order_no).each { |page| page.increment!(:order_no) }
  end

  after_destroy do |page|
    Page.where("order_no > ?", page.order_no).each { |page| page.decrement!(:order_no) }
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

  def self.authenticate(user_hash)
    if user = find_by_username(user_hash[:username])
      if user.password_hash == Encryption::encrypt(user_hash[:password], user.password_salt)
        return user
      end
    end
  end

  before_create :encrypt_password

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = Helpers.encrypt(password, password_salt)
  end
end

class Video < ActiveRecord::Base
end

class Audio < ActiveRecord::Base
  attr_accessor :audio_file

  def received_audio_file?
    audio_file
  end

  before_create :fill_columns, :upload_file, :if => :received_audio_file?
  before_create :convert_to_ogg, :if => :ogg
  before_create :take_care_about_the_number_of_files

  def fill_columns
    self.original_name = audio_file[:filename].sub(/\.\w{2,5}$/, '')
    self.uploaded_filename = Helpers.urlize(audio_file[:filename])
    self.ogg = false if ogg.nil?
  end

  def upload_file
    path_to_file = "public/audio/#{uploaded_filename}"
    File.open(path_to_file, 'w') { |f| f.write audio_file[:tempfile].read }
  end

  def convert_to_ogg
    original_filename = File.expand_path "public/audio/#{uploaded_filename}"
    ogg_filename = original_filename.sub(/\.\w{2,5}$/, '.ogg')
    system "ffmpeg -i \"#{original_filename}\" -acodec libvorbis -ac 2 \"#{ogg_filename}\""
    self.ogg = false if not File.exists? ogg_filename
  end

  def take_care_about_the_number_of_files
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
