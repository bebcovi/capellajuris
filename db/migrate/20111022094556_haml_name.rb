class HamlName < ActiveRecord::Migration
  def change
    rename_column :pages, :url_name, :haml_name
  end
end
