class Content < Sequel::Model
  set_schema do
    primary_key :id
    column :title, 'varchar(255)'
    column :body, 'text'
  end

  def body=(text)
    text = text.gsub("\r\n", "\n") if text.respond_to? :gsub
    super(text)
  end
end
