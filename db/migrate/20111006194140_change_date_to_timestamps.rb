class ChangeDateToTimestamps < ActiveRecord::Migration
  def up
    change_column :news, :created_at, :timestamp
  end

  def down
    change_column :news, :created_at, :date
  end
end
