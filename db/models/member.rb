class Member < ActiveRecord::Base
  VOICES = {
    's' => 'soprani',
    'a' => 'alti',
    't' => 'tenori',
    'b' => 'basi'
  }

  def self.voices
    VOICES.values
  end

  def self.by_voice(name)
    where(:voice => VOICES.key(name).capitalize)
  end

  def self.voice_abbr(voice)
    VOICES.key(voice)
  end

  def name
    "#{first_name} #{last_name}"
  end
  alias to_s name
end
