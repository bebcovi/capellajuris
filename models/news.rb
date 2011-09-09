class News < Sequel::Model
  set_schema do
    primary_key :id
    column :title, 'varchar(255)'
    column :body, 'text'
    column :created_at, 'date'
  end
end
