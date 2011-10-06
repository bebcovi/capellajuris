class News < ActiveRecord::Base
  before_create do |news|
    news.created_at = Date.today
  end
end
