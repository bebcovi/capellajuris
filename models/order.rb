class Order < Sequel::Model
  create_table do
    primary_key :id
    column :title, 'varchar(255)'
    column :order, 'smallint', :unique => true
  end unless table_exists?
end
