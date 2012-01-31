class ChangeVocalRangeToVoice < ActiveRecord::Migration
  def up
    rename_column :members, :vocal_range, :voice
  end
end
