class CreateIntros < ActiveRecord::Migration
  def change
    create_table :intros do |t|
      t.string :title
      t.text :text
      t.text :photo_link
      t.string :video_title
      t.string :video

      t.datetime :updated_at
    end
  end
end
