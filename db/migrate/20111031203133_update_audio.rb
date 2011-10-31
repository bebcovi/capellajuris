# encoding: UTF-8
class UpdateAudio < ActiveRecord::Migration
  class Audio < ActiveRecord::Base
  end
  def up
    Sidebar.first.update_attributes(:audio => 'Makedonsko Devojče')
    Audio.create(:original_name => 'Makedonsko Devojče', :uploaded_filename => 'makedonsko_devojce.mp3', :ogg => true)
  end

  def down
  end
end
