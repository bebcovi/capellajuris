class Page < ActiveRecord::Base
  validates :url_name, :uniqueness => true
end
