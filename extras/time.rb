# encoding: UTF-8
class Time
  CRO_NAMES = {
    1  => "siječnja",
    2  => "veljače",
    3  => "ožujka",
    4  => "travnja",
    5  => "svibnja",
    6  => "lipnja",
    7  => "srpnja",
    8  => "kolovoza",
    9  => "rujna",
    10 => "listopada",
    11 => "studenoga",
    12 => "prosinca"
  }

  alias original_to_s to_s

  def to_s(how = nil)
    if how == :cro
      "#{self.day}. #{CRO_NAMES[self.month]}, #{self.year}"
    elsif how == :time_tag
      original_to_s.sub(/ /,'T').delete(' ').sub(/\d{2}$/, ':\0')
    else
      original_to_s
    end
  end
end
