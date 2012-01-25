class RemoveTablesWhichAreCurrentlyNotNecessary < ActiveRecord::Migration
  def up
    drop_table :about_us_contents
    drop_table :general_contents
    drop_table :intros
  end

  def down
    create_table "about_us_contents" do |t|
      t.integer  "content_id"
      t.string   "content_type"
      t.integer  "content_order"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "general_contents" do |t|
      t.string   "title"
      t.text     "photo_link"
      t.text     "text"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "intros" do |t|
      t.string   "title"
      t.text     "text"
      t.text     "photo_link"
      t.string   "video_title"
      t.string   "video"
      t.datetime "updated_at"
    end
  end
end
