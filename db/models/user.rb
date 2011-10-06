class User < ActiveRecord::Base
  before_create :encrypt_password

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password_hash, password_salt)
  end
end
