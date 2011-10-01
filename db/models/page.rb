class Page < Sequel::Model
  set_schema do
    column :haml_name, 'varchar(30)', :primary_key => true
    column :cro_name, 'varchar(30)'
    column :order, 'tinyint'
  end

  create_table unless table_exists?
end
