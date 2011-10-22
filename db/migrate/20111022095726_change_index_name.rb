class ChangeIndexName < ActiveRecord::Migration
  def up
    Page.find(1).update_attribute(:haml_name, 'index')
  end

  def down
    Page.find(1).update_attribute(:haml_name, '')
  end
end
