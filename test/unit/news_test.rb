require 'test_helper'

class NewsTest < ActiveSupport::TestCase
  test "news validations" do
    assert !News.new.save, "News with blank title and text was saved"
  end
end
