class Content < ActiveRecord::Base
  def move(direction)
    case direction
    when 'up'; switch_content = Content.by_page(page).find_by_order_no(order_no - 1)
    when 'down'; switch_content = Content.by_page(page).find_by_order_no(order_no + 1)
    end
    self.order_no, switch_content.order_no = switch_content.order_no, self.order_no
    self.save; switch_content.save
    return self
  end

  def self.by_page(page)
    where(:page => page)
  end

  before_create do
    unless order_no.present?
      self.order_no = Content.by_page(page).maximum(:order_no).to_i + 1
    end
  end
end
