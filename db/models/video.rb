class Video < Sequel::Model
  def before_create
    self.url.
      gsub!(/height=('|")\d+('|")/, "height=\"338\"").
      gsub!(/width=('|")\d+('|")/, "width=\"560\"")
  end
end
