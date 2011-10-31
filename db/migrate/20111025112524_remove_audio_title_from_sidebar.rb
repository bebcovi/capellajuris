class RemoveAudioTitleFromSidebar < ActiveRecord::Migration
  def up
    remove_column :sidebars, :audio_title
  end
  def down
    add_column :sidebars, :audio_title, :string
  end
end
