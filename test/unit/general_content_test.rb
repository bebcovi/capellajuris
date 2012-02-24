require 'test_helper'

class GeneralContentTest < ActiveSupport::TestCase
  test "validations" do
    assert !GeneralContent.new(:text => "Some markdown").save, "General content with a blank title was saved."
    assert !GeneralContent.new(:title => "Title").save, "General content with blank text was saved."
  end
end
