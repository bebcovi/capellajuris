class Member < Sequel::Model
  set_schema do
    primary_key :id
    column :first_name, 'varchar(50)'
    column :last_name, 'varchar(50)'
    column :voice, 'char(1)'
  end

  VOICES = {
    'S' => 'soprani',
    'A' => 'alti',
    'T' => 'tenori',
    'B' => 'basi'
  }

  def self.voices
    VOICES.values
  end

  def self.by_voice(name)
    filter(:voice => VOICES.index(name))
  end

  def name
    "#{first_name} #{last_name}"
  end
  alias to_s name

  def validate
    super
    validates_presence [:first_name, :last_name], :message => 'Ime i prezime ne smiju biti prazni.'
  end
end
