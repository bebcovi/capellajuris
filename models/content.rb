class Content < Sequel::Model
  set_schema do
    primary_key :id
    column :title, 'varchar(255)'
    column :body, 'text'
  end

  create_table unless table_exists?

  def body=(text)
    text = text.gsub("\r\n", "\n") if text.respond_to? :gsub
    super(text)
  end
end
