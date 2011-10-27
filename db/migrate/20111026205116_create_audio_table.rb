class CreateAudioTable < ActiveRecord::Migration
  def change
    create_table :audios do |t|
      t.primary_key :id
      t.string :original_name
      t.string :uploaded_filename
      t.boolean :ogg
    end
  end
end
