require 'test_helper'

class SidebarTest < ActiveSupport::TestCase
  test "validations" do
    assert !Sidebar.new(:video => "Video").save, "Saved sidebar with empty video title."
    assert !Sidebar.new(:video_title => "Video title").save, "Saved sidebar with empty video."
  end

  test "callbacks" do
    assert_equal Sidebar.create(:video_title => "Video title", :video => %(<iframe width="480" height="360" src="http://www.youtube.com/embed/WGoi1MSGu64" frameborder="0" allowfullscreen></iframe>)).video,
      %(<iframe width='480' height='360' src='http://www.youtube.com/embed/WGoi1MSGu64' frameborder='0' allowfullscreen></iframe>)
  end
end
