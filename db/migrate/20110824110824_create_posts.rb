class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.string :subtitle
      t.text :body
      t.date :created_at
    end
  end

  def self.down
    drop_table :posts
  end
end
