require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  test "activities validations" do
    assert !Activity.new.save, "Activity with blank fields was saved."
    assert !Activity.new(:year => "2009.", :bullets => "Lorem ipsum").save, "Activity saved even though the year wasn't a number."
  end
end
