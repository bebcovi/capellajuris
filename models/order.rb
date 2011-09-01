class Order < Sequel::Model
  create_table do
    column :title, 'varchar(255)', :primary_key => true
    column :order, 'smallint'
  end unless table_exists?
end
