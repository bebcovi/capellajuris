# encoding:utf-8
class Sidebar < Sequel::Model
  set_schema do
    primary_key :id
    column :video_title, 'varchar(50)'
    column :video_url, 'varchar(255)'
    column :audio_title, 'varchar(50)'
    column :audio_url, 'varchar(255)'
  end
end
