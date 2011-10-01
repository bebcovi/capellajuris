class Content < Sequel::Model
  def self.by_page(page)
    filter(:page => page)
  end

  def before_create
    self.order = Content.by_page(page).max(:order).to_i + 1
    super
  end
end
