# encoding: UTF-8
class Content < ActiveRecord::Base
  def move(direction)
    delta = case direction
    when '▲' then -1
    when '▼' then 1
    end
    if other = on_same_page.find_by_order_no(order_no + delta)
      switch_positions other
    end
    return self
  end

  def switch_positions(other)
    self.order_no, other.order_no = other.order_no, self.order_no
    self.save
    other.save
  end

  def on_same_page
    self.class.by_page(page)
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
