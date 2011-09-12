# encoding:utf-8
class OtherContent < Sequel::Model
  set_schema do
    primary_key :id
    column :title, 'varchar(255)'
    column :body, 'text'
    column :photo_id, 'int', :unsigned => true
    column :photo_size, 'varchar(10)'
    column :photo_float, 'varchar(10)'
    column :photo_paragraph, 'tinyint', :unsigned => true
  end

  def before_validation
    if photo_id =~ /@[^\/]*\/(\d+)/
      self.photo_id = $1.to_i
    end
    unless photo_id.blank?
      if photo_paragraph.blank?
        self.photo_paragraph = 1
      else
        self.photo_paragraph = photo_paragraph.to_i
      end

      if photo_float.blank?
        self.photo_float = 'Lijevo'
      else
        self.photo_float.capitalize!
      end
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
      errors.add(column, 'Upisana veličina nije validna Flickr veličina.')
    elsif not @photo.available_sizes.include? string_to_method(photo_size)
      errors.add(column, 'Veličina nije dostupna (ni na Flickru ne bi trebala biti dostupna).')
    end
  end

  def validates_paragraph_existence(column)
    paragraph_number = body.split("\n\n").count
    if photo_paragraph > paragraph_number
      errors.add(column, "Upisani redni broj paragrafa je veći od ukupnog broja paragrafa #{paragraph_number}.")
    elsif photo_paragraph <= 0
      errors.add(column, "Upisani redni broj paragrafa nije pozitivan.")
    end
  end

  def validate
    super
    unless photo_id.blank?
      validates_photo_id :photo_id
      unless errors.has_key?(:photo_id) or photo_size.blank?
        validates_photo_size :photo_size
        validates_paragraph_existence :photo_paragraph
        validates_includes %w[ Lijevo Desno Gore Dolje ], :photo_float,
                                                          :message => "(\"Lijevo\", \"Desno\", \"Gore\" ili \"Dolje\")"
      end
    end
  end

  def before_save
    if photo_size.blank? and not photo_id.blank?
      self.photo_size = @photo.largest_size
      @photo = nil
    end
    super
  end

  def after_create
    super
    Content.create(:content_id => id,
                   :type => 'other_content',
                   :order => Content.by_page(session[:page]).max(:order) + 1,
                   :page => session[:page])
  end

  def before_destroy
    @content = Content[:content_id => id]
    Content.by_page(@content.page).each do |content|
      if content.order > @content.order
        temp = Content[content.id]
        temp.order -= 1
        temp.save
      end
    end
    @content.delete
    super
  end
end
