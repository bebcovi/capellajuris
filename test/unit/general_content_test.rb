require 'test_helper'

class GeneralContentTest < ActiveSupport::TestCase
  test "general_content validations" do
    assert !GeneralContent.new.save, "General content with blank title and text was saved"
  end
end
