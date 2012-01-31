class CreateSidebars < ActiveRecord::Migration
  def change
    create_table :sidebars do |t|
      t.string :video_title
      t.text :video
      t.string :audio_title
      t.text :audio
      t.datetime :updated_at
    end
  end
end
