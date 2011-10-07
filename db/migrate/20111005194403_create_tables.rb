class CreateTables < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.primary_key :id
      t.text :text
      t.string :content_type
      t.string :page
      t.integer :order_no, :limit => 1
    end

    create_table :members do |t|
      t.primary_key :id
      t.string :first_name
      t.string :last_name
      t.string :voice, :limit => 1
    end

    create_table :news do |t|
      t.primary_key :id
      t.timestamp :created_at
      t.text :text
    end

    create_table :pages do |t|
      t.primary_key :id
      t.string :haml_name
      t.string :cro_name
      t.integer :order_no, :limit => 1
    end

    create_table :sidebars do |t|
      t.primary_key :id
      t.string :video_title
      t.string :video
      t.string :audio_title
      t.string :audio
    end

    create_table :users do |t|
      t.primary_key :id
      t.string :username
      t.string :password_hash
      t.string :password_salt
    end

    create_table :videos do |t|
      t.primary_key :id
      t.string :url
      t.string :title
    end
  end
end
