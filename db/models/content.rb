# encoding:utf-8
class Content < Sequel::Model
  set_schema do
    primary_key :id
    column :text, 'text'
    column :type, 'varchar(255)'
    column :page, 'varchar(255)'
    column :order, 'tinyint'
  end

  def self.by_page(page)
    filter(:page => page)
  end

  def before_create
    self.order = Content.by_page(page).max(:order) + 1
    super
  end
end
