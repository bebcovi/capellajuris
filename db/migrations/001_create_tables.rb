Sequel.migration do
  change do
    Dir['models/*'].each do |model_path|
      model = model_path.match('([^/]+).rb$')[1].capitalize
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        #{model}.create_table
      RUBY
    end
  end
end
