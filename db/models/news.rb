class News < ActiveRecord::Base
  def created_at
    read_attribute(:created_at).to_s.match(/\d+\-\d+\-\d+/)[0].to_date
  end

  before_create do |news|
    news.created_at = Time.now.to_timestamp
  end
end
