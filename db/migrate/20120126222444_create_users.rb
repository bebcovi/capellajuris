class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :encrypted_password
      t.string :password_salt
      t.string :flickr_set_url
    end
  end
end
