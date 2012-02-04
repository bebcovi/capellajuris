require 'test_helper'

class SidebarTest < ActiveSupport::TestCase
  test "sidebar validations" do
    assert !Sidebar.new.save, "Saved sidebar with empty fields"
  end
end
