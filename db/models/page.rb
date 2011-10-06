class Page < ActiveRecord::Base
  validates :haml_name, :uniqueness => true
end
