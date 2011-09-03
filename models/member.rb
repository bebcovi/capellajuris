class Member < Sequel::Model
  set_schema do
    primary_key :id
    column :first_name, 'varchar(50)'
    column :last_name, 'varchar(50)'
    column :voice, 'char(1)'
  end

  create_table unless table_exists?
end
