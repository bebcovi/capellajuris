class Member < ActiveRecord::Base
  def self.by_voice(voice)
    where("vocal_range = ?", voice[0].capitalize)
  end

  def to_s
    first_name + " " + last_name
  end
end
