require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  test "video validations" do
    assert !Video.new.save, "Video with blank link was saved."
    assert_equal Video.create(:link => %(<iframe width="480" height="360" src="http://www.youtube.com/embed/WGoi1MSGu64" frameborder="0" allowfullscreen></iframe>)).link,
      %(<iframe width='480' height='360' src='http://www.youtube.com/embed/WGoi1MSGu64' frameborder='0' allowfullscreen></iframe>)
  end
end
