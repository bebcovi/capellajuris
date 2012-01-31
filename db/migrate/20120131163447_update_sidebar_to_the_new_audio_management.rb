class UpdateSidebarToTheNewAudioManagement < ActiveRecord::Migration
  def up
    add_column :audios, :sidebar_id, :integer
    remove_column :sidebars, :audio_title
    remove_column :sidebars, :audio
  end

  def down
    remove_column :audios, :sidebar_id
    add_column :sidebars, :audio_title, :string
    add_column :sidebars, :audio, :string
  end
end
