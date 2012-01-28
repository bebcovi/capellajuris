class Member < ActiveRecord::Base
  validates_presence_of :first_name, :message => "Ime ne smije biti prazno"
  validates_presence_of :last_name, :message => "Prezime ne smije biti prazno"
  validates_presence_of :vocal_range, :message => "Glas ne smije biti prazan"

  def self.by_voice(voice)
    where("vocal_range = ?", voice[0].capitalize)
  end

  def to_s
    first_name + " " + last_name
  end
end
