class ChangePhotoLinkToPhotoUrl < ActiveRecord::Migration
  def change
    rename_column :general_contents, :photo_url, :photo_link
  end
end
