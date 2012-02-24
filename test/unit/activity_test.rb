require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  test "validations" do
    assert !Activity.new(:bullets => "Some markdown").save, "Activity with blank year was saved."
    assert !Activity.new(:year => 2012).save, "Activity with blank bullets was saved."
    assert !Activity.new(:year => "2009.", :bullets => "Lorem ipsum").save, "Activity saved even though the year wasn't a number."
  end
end
