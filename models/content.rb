class Content < Sequel::Model
  create_table do
    primary_key :id
    column :title, 'varchar(255)'
    column :body, 'text'
  end unless table_exists?
end
