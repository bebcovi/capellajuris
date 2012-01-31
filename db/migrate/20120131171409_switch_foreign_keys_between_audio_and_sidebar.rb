class SwitchForeignKeysBetweenAudioAndSidebar < ActiveRecord::Migration
  def up
    remove_column :audios, :sidebar_id
    add_column :sidebars, :audio_id, :integer
  end

  def down
    add_column :audios, :sidebar_id, :integer
    remove_column :sidebars, :audio_id
  end
end
