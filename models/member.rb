class Member < Sequel::Model
  create_table do
    primary_key :id
    column :first_name, 'varchar(50)'
    column :last_name, 'varchar(50)'
    column :voice, 'char(1)'
  end unless table_exists?
end
