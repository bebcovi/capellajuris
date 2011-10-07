class User < ActiveRecord::Base
  before_create :encrypt_password
  attr_accessor :password

  def encrypt(password)
    BCrypt::Engine.hash_secret(password, password_salt)
  end

  def self.authenticate(username, password)
    if user = where(:username => username).first
      return user if user.password_hash == encrypt(password)
    end
  end

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = encrypt(password)
  end
end
