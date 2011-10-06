class Video < ActiveRecord::Base
  before_save :set_equal_dimensions

  def set_equal_dimensions
    self.url.
      gsub!(/height=('|")\d+('|")/, "height=\"338\"").
      gsub!(/width=('|")\d+('|")/, "width=\"560\"")
  end
end
