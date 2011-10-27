class RemoveAudioTitleFromSidebar < ActiveRecord::Migration
  def change
    remove_column :sidebars, :audio_title
  end
end
