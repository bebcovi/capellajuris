class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :link
      t.datetime :created_at
    end
  end
end
