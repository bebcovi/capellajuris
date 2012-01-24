class CreateGeneralContents < ActiveRecord::Migration
  def change
    create_table :general_contents do |t|
      t.string :title
      t.text :photo_url
      t.text :text

      t.timestamps
    end
  end
end
