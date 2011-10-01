Sequel.migration do
  change do
    alter_table :users do
      rename_column :password, :password_hash
      add_column :password_salt, 'varchar(255)'
    end
  end
end
