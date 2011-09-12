class News < Sequel::Model
  set_schema do
    primary_key :id
    column :created_at, 'date'
    column :text, 'text'
  end
end
