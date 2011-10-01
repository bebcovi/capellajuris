class Page < Sequel::Model
  create_table unless table_exists?
end
