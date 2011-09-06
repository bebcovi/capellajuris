class Intro < Sequel::Model
  set_schema do
    column :title, 'varchar(255)', :primary_key => true
    column :body, 'text'
    column :photo_url, 'varchar(255)'
    column :photo_size, 'varchar(255)'
    column :video_title, 'varchar(255)'
    column :video_height, 'smallint'
    column :video_width, 'smallint'
    column :audio_title, 'varchar(255)'
  end
end
