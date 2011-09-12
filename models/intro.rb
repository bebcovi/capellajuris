# encoding:utf-8
class Intro < Sequel::Model
  set_schema do
    column :title, 'varchar(255)', :primary_key => true
    column :body, 'text'
    column :photo_id, 'int'
    column :photo_size, 'varchar(255)'
    column :video_title, 'varchar(255)'
    column :video_url, 'varchar(255)'
    column :audio_title, 'varchar(255)'
    column :audio_url, 'varchar(255)'
  end

  unrestrict_primary_key

  def before_validation
    if photo_id =~ /@[^\/]*\/(\d+)/
      self.photo_id = $1.to_i
    end

    unless video_url.blank?
      video_url.gsub!('watch?v=', 'embed/')
      video_url.concat('?rel=0') unless video_url.match(/\?rel\=0$/)
    end
    super
  end

  def validates_photo_id(column)
    begin
      @photo = Flickr.find_photo(photo_id)
    rescue Flickr::Error => e
      errors.add(column, "Greška dohvaćanja Flickr slike: #{e.message}.")
    rescue Timeout::Error
      errors.add(column, "Veza sa Flickrom je trenutno spora. Pokušaj ponovno.")
    end
  end

  def validates_photo_size(column)
    if not flickr_sizes.include? string_to_method(photo_size)
      errors.add(column, "Upisana veličina nije validna Flickr veličina.")
    elsif not @photo.available_sizes.include? string_to_method(photo_size)
      errors.add(column, "Veličina nije dostupna (ni na Flickru ne bi trebala biti dostupna).")
    end
  end

  def validates_audio_existence(column)
    if not Dir['public/audio/*'].include? "public/audio/#{audio_url}"
      errors.add(column, 'Audio snimka s tim imenom ne postoji.')
    end
  end

  def validate
    super
    unless photo_id.blank?
      validates_photo_id :photo_id
      unless errors.has_key?(:photo_id) or photo_size.blank?
        validates_photo_size :photo_size
      end
    end
    validates_presence :video_url, :message => 'Video snimka nije upisana.'
    validates_presence :audio_url, :message => 'Audio snimka nije upisana.'
    validates_audio_existence :audio_url unless errors.has_key? :audio_url
  end

  def before_save
    if photo_size.blank? and not photo_id.blank?
      self.photo_size = @photo.largest_size
      @photo = nil
    end
    super
  end
end
