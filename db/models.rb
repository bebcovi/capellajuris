# encoding: UTF-8
class Content < ActiveRecord::Base
  def move(direction)
    delta = case direction
    when '▲' then -1
    when '▼' then 1
    end
    if other = on_same_page.find_by_order_no(order_no + delta)
      switch_positions other
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

  def name
    "#{first_name} #{last_name}"
  end
  alias to_s name
end

class News < ActiveRecord::Base
  self.per_page = 10
end

class Page < ActiveRecord::Base
  before_create do |page|
    page.url_name = Helpers.urlize(page.cro_name)
    page.order_no = Page.find_by_url_name('slike').order_no
    Page.where("order_no >= ?", page.order_no).each do |page_to_be_moved|
      page_to_be_moved.order_no += 1
      page_to_be_moved.save
    end
  end

  after_destroy do |page|
    Page.where("order_no > ?", page.order_no).each do |page_to_be_moved|
      page_to_be_moved.order_no -= 1
      page_to_be_moved.save
    end
  end
end

class Sidebar < ActiveRecord::Base
  validate :audio_existence

  def audio_existence
    if not Dir['public/audio/*'].include? "public/audio/#{audio}.mp3"
      errors.add(:audio, "Audio snimka s tim imenom ne postoji.")
    end
  end

  def video
    video = Hpricot(read_attribute(:video)).at(:iframe)
    video[:height], video[:width] = '180', '306'
    return video.to_html
  end
end

class User < ActiveRecord::Base
  attr_accessor :password

  def self.authenticate(username, password)
    if user = find_by_username(username)
      if user.password_hash == Encryption::encrypt(password, user.password_salt)
        return user
      end
    end
  end

  before_create :encrypt_password

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = Encryption::encrypt(password, password_salt)
  end
end

class Video < ActiveRecord::Base
end
