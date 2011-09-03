class Activity < Sequel::Model
  set_schema do
    primary_key :id
    column :year, 'smallint'
    column :things, 'text'
  end

  create_table unless table_exists?
end
