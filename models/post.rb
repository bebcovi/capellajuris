class Post < Sequel::Model
  set_schema do
    primary_key :id
    column :title, 'varchar(255)'
    column :body, 'text'
    column :created_at, 'date'
  end

  create_table unless table_exists?
end
