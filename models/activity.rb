class Activity < Sequel::Model
  set_schema do
    column :year, 'smallint', :primary_key => true
    column :things, 'text'
  end
end
