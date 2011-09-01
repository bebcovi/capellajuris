class User < Sequel::Model
  create_table do
    primary_key :id
    column :username, 'varchar(50)'
    string :password, 'varchar(50)'
  end unless table_exists?
end
