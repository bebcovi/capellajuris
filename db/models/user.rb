class User < Sequel::Model
  def before_create
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password_hash, password_salt)
    super
  end
end
