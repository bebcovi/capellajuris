class News < Sequel::Model
  def before_create
    self.created_at = Date.today
  end
end
