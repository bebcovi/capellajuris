class RenameToMoreMeaningfulColumnNames < ActiveRecord::Migration
  def change
    rename_column :videos, :url, :embed_code
  end
end
