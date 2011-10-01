class User < Sequel::Model
  set_schema do
    primary_key :id
    column :username, 'varchar(50)'
    column :password, 'varchar(255)'
  end

  def before_create
    self.password = BCrtpt::Password.create(password)
    super
  end
end
