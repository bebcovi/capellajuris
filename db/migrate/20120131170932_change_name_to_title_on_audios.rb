class ChangeNameToTitleOnAudios < ActiveRecord::Migration
  def change
    rename_column :audios, :name, :title
  end
end
