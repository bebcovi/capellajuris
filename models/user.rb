class User < Sequel::Model
  set_schema do
    primary_key :id
    string :username
    string :password
  end

  unless table_exists?
    create_table
  end
end
