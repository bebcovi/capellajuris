class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.text :text
      t.text :photo_link
      t.date :created_at
    end
  end
end
