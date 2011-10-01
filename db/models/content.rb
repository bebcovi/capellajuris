# encoding:utf-8
class Content < Sequel::Model
  def self.by_page(page)
    filter(:page => page)
  end

  def before_create
    self.order = Content.by_page(page).max(:order) + 1
    super
  end
end
