class RemoveUpdateAtColumnFromMembers < ActiveRecord::Migration
  def up
    remove_column :members, :updated_at
  end

  def down
    add_column :members, :updated_at, :datetime
  end
end
