class Video < Sequel::Model
  set_schema do
    primary_key :id
    column :url, 'varchar(255)'
    column :title, 'varchar(255)'
  end
end
