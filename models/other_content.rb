# encoding:utf-8
class OtherContent < Sequel::Model
  set_schema do
    primary_key :id
    column :title, 'varchar(255)'
    column :body, 'text'
    column :photo_id, 'varchar(255)'
    column :photo_alt, 'varchar(255)'
    column :photo_size, 'varchar(255)'
    column :photo_float, 'varchar(10)'
    column :photo_paragraph, 'tinyint'
  end

  def before_validation
    if photo_paragraph.blank?
      photo_paragraph = 1
    else
      photo_paragraph = photo_paragraph.to_i
    end

    begin
      if photo_size.blank?
        @photo = Fleakr::Objects::Photo.find_by_id(photo_id).largest
        photo_size = "#{@photo.width}x#{@photo.height}"
      else
        photo_size.downcase!.delete!(' ')
        @photo = Fleakr::Objects::Photo.find_by_id(photo_id).send(photo_size)
        photo_size = "#{@photo.width}x#{@photo.height}"
      end
    rescue Fleakr::ApiError
    end

    if photo_float.blank?
      photo_float = 'lijevo'
    else
      photo_float.downcase!
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

  def validates_paragraph_existence(column)
    paragraph_count = body.split("\n\n").length
    if photo_paragraph > paragraph_count
      errors.add(column, "Upisani broj paragrafa je veći od ukupnog broja paragrafa (#{paragraph_count}).")
    end
  end

  def validates_photo_size(column)
    if match(/[^0-9]+/)
      if not flickr_photo_sizes.include?(photo_size)
        errors.add(column, "Upisana veličina slike ne odgovara niti jednoj od Flickr-ovih veličina.")
      elsif Flickr::Objects::Photo.find_by_id(photo_id).send(photo_size) == nil
        errors.add(column, 'Upisana veličina slike nije dopuštena (na Flickr-u ta veličina ne bi trebala biti ponuđena).')
      end
    else
      if photo_size <= 0
        errors.add(column, 'Upisana veličina slike nije pozitivna.')
      elsif Flickr::Objects::Photo.find_by_id(photo_id).send(nearest_size(photo_id)) == nil
        errors.add(column, 'Upisana veličina slike nije dopuštena (na Flickr-u ta veličina ne bi trebala biti ponuđena).')
      end
    end
  end

  def validate
    super
    unless photo_size.blank?
      validates_photo_id :photo_id
      unless errors.has_key? :photo_id
        validates_presence :photo_alt, :message => 'Opis slike nije upisan.'
        validates_paragraph_existence :photo_paragraph
        validates_includes ['lijevo', 'desno', 'gore', 'dolje'], :photo_float, :message => 'Lijevo, desno, gore ili dolje.'
        validates_photo_size :photo_size
      end
    end
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
