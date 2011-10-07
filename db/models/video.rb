class Video < ActiveRecord::Base
  before_save :set_equal_dimensions

  def set_equal_dimensions
    self.url.
      sub!(/height=('|")\d+('|")/, "height=\"338\"").
      sub!(/width=('|")\d+('|")/, "width=\"560\"") if url.present?
  end
end
