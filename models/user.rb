class User < Sequel::Model
  set_schema do
    primary_key :id
    column :username, 'varchar(50)'
    column :password, 'varchar(50)'
  end

  create_table unless table_exists?
end
