# encoding:utf-8
class Intro < Sequel::Model
  set_schema do
    column :title, 'varchar(255)', :primary_key => true
    column :body, 'text'
    column :photo_id, 'varchar(255)'
    column :photo_alt, 'varchar(255)'
    column :photo_size, 'varchar(255)'
    column :video_title, 'varchar(255)'
    column :video_url, 'varchar(255)'
    column :audio_title, 'varchar(255)'
    column :audio_url, 'varchar(255)'
  end

  unrestrict_primary_key

  def before_validation
    begin
      if photo_size.blank?
        @photo = Fleakr::Objects::Photo.find_by_id(photo_id).largest
        photo_size = "#{@photo.width}x#{@photo.height}"
      end
    rescue Fleakr::ApiError
    end

    unless video_url.blank?
      video_url.gsub!('watch?v=', 'embed/')
      video_url.concat('?rel=0') unless video_url.match(/\?rel\=0$/)
    end
    super
  end

  def validates_photo_id(column)
    begin
      Fleakr::Objects::Photo.find_by_id(photo_id)
    rescue Fleakr::ApiError
      errors.add(column, "Slika s upisanim ID-om nije pronađena na tvom Flickr accountu.")
    end
  end

  def validates_photo_size(column)
    if photo_size.match(/[^0-9]+/)
      if photo_size.include? "%"
        errors.add(column, 'Nije validan postotak.') if not photo.size.match(/^\d{1,3}\%$/)
      elsif photo_size.delete('x').match(/^\d+$/)
      elsif not flickr_photo_sizes.include?(string_to_method(photo_size))
        errors.add(column, 'Upisana veličina slike ne odgovara niti jednoj od Flickr-ovih veličina.')
      elsif Flickr::Objects::Photo.find_by_id(photo_id).send(string_to_method(photo_size)) == nil
        errors.add(column, 'Upisana veličina slike nije dopuštena (na Flickr-u ta veličina ne bi trebala biti ponuđena).')
      end
    else
      if photo_size.to_i <= 0
        errors.add(column, 'Upisana veličina slike nije pozitivna.')
      elsif Flickr::Objects::Photo.find_by_id(photo_id).send(nearest_size(photo_size)) == nil
        errors.add(column, 'Upisana veličina slike nije dopuštena (na Flickr-u ta veličina ne bi trebala biti ponuđena).')
      end
    end
  end

  def validates_audio_existence(column)
    if not Dir['public/audio/*'].include? "public/audio/#{audio_url}"
      errors.add(column, 'Audio snimka s tim imenom ne postoji.')
    end
  end

  def validate
    super
    unless photo_size.blank?
      validates_photo_id :photo_id
      unless errors.has_key? :photo_id
        validates_presence :photo_alt, :message => 'Opis slike nije upisan.'
        validates_photo_size :photo_size
      end
    end
    validates_presence :video_url, :message => 'Video snimka nije upisana.'
    validates_presence :audio_url, :message => 'Audio snimka nije upisana.'
    validates_audio_existence :audio_url unless errors.has_key? :audio_url
  end

  def before_save
    @photo = Fleakr::Objects::Photo.find_by_id(photo_id)
    if @photo.get_sizes.include?(string_to_method(photo_size))
      @photo = @photo.send(string_to_method(photo_size))
      self.photo_size = "#{@photo.width}x#{@photo.height}"
    elsif photo_size !~ /\D/
      @photo = @photo.largest
      self.photo_size = "#{photo_size}x#{(@photo.height.to_f/(@photo.width.to_f/photo_size.to_f)).round}"
    elsif photo_size.include? '%'
      @photo = @photo.largest
      multiplier = photo_size.chomp.to_i / 100.0
      self.photo_size = "#{(@photo.width.to_i * multiplier).round}x#{(@photo.height.to_i * multiplier).round}"
    end
    super
  end
end
