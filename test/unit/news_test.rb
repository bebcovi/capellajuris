require 'test_helper'

class NewsTest < ActiveSupport::TestCase
  test "validations" do
    assert !News.new(:text => "Some markdown").save, "News with blank title was saved."
    assert !News.new(:title => "Title").save, "News with blank text was saved."
  end

  test "callbacks" do
    100.times { |n| News.create(:title => "Title #{n}", :text => "Text #{n}", :created_at => n.minutes.from_now) }
    assert_not_nil News.find_by_title("Title 0")
    News.create(:title => "Title 101", :text => "Text 101")
    assert_nil News.find_by_title("Title 0")
  end
end
