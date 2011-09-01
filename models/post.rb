class Post < Sequel::Model
  create_table do
    primary_key :id
    column :title, 'varchar(255)'
    column :subtitle, 'varchar(255)'
    column :body, 'text'
    column :created_at, 'date'
  end unless table_exists?
end
