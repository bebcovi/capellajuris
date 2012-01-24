class CreateAboutUsContents < ActiveRecord::Migration
  def change
    create_table :about_us_contents do |t|
      t.integer :content_id
      t.string :content_type
      t.integer :content_order

      t.timestamps
    end
  end
end
