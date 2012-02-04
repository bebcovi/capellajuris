class ChangeNewsCreatedAtTypeToDatetime < ActiveRecord::Migration
  def up
    change_column :news, :created_at, :datetime
  end

  def down
    change_column :news, :created_at, :date
  end
end
