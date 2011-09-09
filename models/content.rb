# encoding:utf-8
class Content < Sequel::Model
  set_schema do
    primary_key :id
    column :content_id, 'smallint'
    column :title, 'varchar(255)'
    column :type, 'varchar(30)'
    column :order, 'tinyint'
    column :page, 'varchar(30)'
  end

  def self.by_page(page)
    filter(:page => page)
  end
end
