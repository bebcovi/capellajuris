#encoding:utf-8
class Date
  CRO_NAMES = {
    1 => "siječnja",
    2 => "veljače",
    3 => "ožujka",
    4 => "travnja",
    5 => "svibnja",
    6 => "lipnja",
    7 => "srpnja",
    8 => "kolovoza",
    9 => "rujna",
    10 => "listopada",
    11 => "studenoga",
    12 => "prosinca"
  }

  alias original_to_s to_s

  def to_s(how = nil)
    if how == :cro
      month_name = CRO_NAMES[self.month]
      "#{self.day}. #{month_name}, #{self.year}"
    else
      original_to_s
    end
  end
end
