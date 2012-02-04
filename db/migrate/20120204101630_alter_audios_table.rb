class AlterAudiosTable < ActiveRecord::Migration
  def up
    remove_column :audios, :files
    add_column :audios, :aac, :string
    add_column :audios, :ogg, :string
  end

  def down
    add_column :audios, :files, :text, :default => []
    remove_column :audios, :aac
    remove_column :audios, :ogg
  end
end
