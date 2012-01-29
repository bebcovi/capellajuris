class CreateGeneralContentsAgain < ActiveRecord::Migration
  def change
    create_table :general_contents do |t|
      t.string :title
      t.text :photo
      t.text :text
      t.datetime :updated_at
    end
  end
end
