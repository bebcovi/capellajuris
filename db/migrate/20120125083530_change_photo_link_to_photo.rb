class ChangePhotoLinkToPhoto < ActiveRecord::Migration
  def change
    rename_column :news, :photo_link, :photo
  end
end
