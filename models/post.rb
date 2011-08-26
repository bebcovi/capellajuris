class Post < Sequel::Model
  set_schema do
    primary_key :id
    string :title
    string :subtitle
    text :body
    date :created_at
  end

  unless table_exists?
    create_table
    create(
      :title => 'Nastup za tjedan dana',
      :subtitle => 'Crkva Sv. Mateja',
      :body => 'Bolje vam je da se pojavite, majke mi.',
      :created_at => Date.today
    )
    create(
      :title => 'Drugi post',
      :subtitle => 'Ovaj put neka druga crkva',
      :body => 'We gathered here on this historic day...',
      :created_at => Date.today
    )
  end
end
