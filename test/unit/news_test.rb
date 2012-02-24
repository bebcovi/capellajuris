require 'test_helper'

class NewsTest < ActiveSupport::TestCase
  test "news validations" do
    assert !News.new(:text => "Some markdown").save, "News with blank title was saved."
    assert !News.new(:title => "Title").save, "News with blank text was saved."
  end
end
