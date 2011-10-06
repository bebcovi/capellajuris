class Content < ActiveRecord::Base
  def self.by_page(page)
    where(:page => page)
  end

  before_create do |content|
    unless order_no.present?
      content.order_no = Content.by_page(page).maximum(:order_no).to_i + 1
    end
  end
end
