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
