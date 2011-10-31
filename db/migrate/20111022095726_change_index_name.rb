class ChangeIndexName < ActiveRecord::Migration
  def up
    Page.first.update_attribute(:haml_name, 'index')
  end

  def down
    Page.first.update_attribute(:haml_name, '')
  end
end
