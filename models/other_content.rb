class OtherContent < Sequel::Model
  set_schema do
    primary_key :id
    column :title, 'varchar(255)'
    column :body, 'text'
    column :photo_src, 'varchar(255)'
    column :photo_height, 'smallint'
    column :photo_alt, 'varchar(255)'
    column :photo_float, 'varchar(10)'
    column :photo_paragraph, 'tinyint'
  end
end
