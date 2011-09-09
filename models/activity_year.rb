# encoding:utf-8
class ActivityYear < Sequel::Model
  set_schema do
    column :title, 'smallint', :primary_key => true
    column :body, 'text'
  end

  unrestrict_primary_key

  def validate
    super
    validates_unique :title, :message => 'Ta godina već postoji. Radije izmijenite tu već postojeću godinu.'
    validates_presence :title, :message => 'Godina ne smije biti prazna.'
  end
end
