class UpdateAudiosForAmazon < ActiveRecord::Migration
  def up
    remove_column :audios, :filename
    add_column :audios, :files, :text, :default => []
  end

  def down
    add_column :audios, :filename, :string
    remove_column :audios, :files
  end
end
