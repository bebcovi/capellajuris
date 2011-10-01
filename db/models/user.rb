class User < Sequel::Model
  set_schema do
    primary_key :id
    column :username, 'varchar(50)'
    column :password, 'varchar(255)'
  end

  def before_create
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password_hash, password_salt)
    super
  end
end
