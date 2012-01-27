class User < ActiveRecord::Base
  attr_accessor :password

  with_options :unless => "self.class.any?" do |registering_user|
    registering_user.validates_presence_of :username, :password, :flickr_set_url
    registering_user.validates_confirmation_of :password, :unless => "password_confirmation.blank?"
    registering_user.validates_format_of :flickr_set_url, :with => /^\d+$/, :unless => "flickr_set_url.blank?"
  end

  def register!
    self.tap do |new_user|
      new_user.password_salt = generate_salt
      new_user.encrypted_password = encrypt_password(new_user.password, new_user.password_salt)
      new_user.flickr_set_url = extract_flickr_set_number(flickr_set_url) if flickr_set_url.present?
      new_user.save
    end
  end

  def extract_flickr_set_number(url)
    if url =~ /^\d+$/
      url
    else
      url =~ /sets\/(\d+)/ or url =~ /set-(\d+)/
      $1 or url
    end
  end

  def self.authenticate(user)
    registered_user = User.first
    authenticating_user = new(user)
    if authenticating_user.username == registered_user.username and passwords_equal?(authenticating_user, registered_user)
      registered_user
    else
      nil
    end
  end

  def self.passwords_equal?(user1, user2)
    encrypt_password(user1.password, user2.password_salt) == user2.encrypted_password
  end

private

  # LAME: Don't know how to extract those methods in a separate module
  def encrypt_password(password, salt)
    BCrypt::Engine.hash_secret(password, salt)
  end

  def self.encrypt_password(password, salt)
    BCrypt::Engine.hash_secret(password, salt)
  end

  def generate_salt
    BCrypt::Engine.generate_salt
  end

  def self.generate_salt
    BCrypt::Engine.generate_salt
  end
end
