class Activity < Sequel::Model
  create_table do
    primary_key :id
    column :things, 'text'
  end unless table_exists?
end
