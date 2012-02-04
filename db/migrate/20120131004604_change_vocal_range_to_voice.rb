class ChangeVocalRangeToVoice < ActiveRecord::Migration
  def change
    rename_column :members, :vocal_range, :voice
  end
end
