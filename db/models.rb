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
  validates :audio,
    :inclusion => {:in => Dir['public/audio/*'].collect { |file| file.match(/([^\/]+)\.\w{3}$/)[1] },
                   :message => 'Audio snimka s tim imenom ne postoji.'}

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
    self.password_hash = Encryption::encrypt(password, password_salt)
  end
end

class Video < ActiveRecord::Base
end
