Sequel.migration do
  change do
    create_table :contents do
      primary_key :id
      column :text, 'text'
      column :type, 'varchar(20)'
      column :page, 'varchar(255)'
      column :order, 'tinyint'
    end

    create_table :members do
      primary_key :id
      column :first_name, 'varchar(50)'
      column :last_name, 'varchar(50)'
      column :voice, 'char(1)'
    end

    create_table :news do
      primary_key :id
      column :created_at, 'date'
      column :text, 'text'
    end

    create_table :pages do
      column :haml_name, 'varchar(30)', :primary_key => true
      column :cro_name, 'varchar(30)'
      column :order, 'tinyint'
    end

    create_table :sidebars do
      primary_key :id
      column :video_title, 'varchar(50)'
      column :video, 'varchar(255)'
      column :audio_title, 'varchar(50)'
      column :audio, 'varchar(255)'
    end

    create_table :users do
      primary_key :id
      column :username, 'varchar(50)'
      column :password, 'varchar(255)'
    end

    create_table :videos do
      primary_key :id
      column :url, 'varchar(255)'
      column :title, 'varchar(255)'
    end
  end
end
