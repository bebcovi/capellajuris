class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :year
      t.text :bullets

      t.timestamps
    end
  end
end
