require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  test "validations" do
    assert !Video.new.save, "Video with blank link was saved."
  end

  test "callbacks" do
    assert_equal Video.create(:link => %(<iframe width="480" height="360" src="http://www.youtube.com/embed/WGoi1MSGu64" frameborder="0" allowfullscreen></iframe>)).link,
      %(<iframe width='480' height='360' src='http://www.youtube.com/embed/WGoi1MSGu64' frameborder='0' allowfullscreen></iframe>)
  end

  test "methods" do
    Video.create! [{:link => "Link 1"}, {:link => "Link 2"}, {:link => "Link 3"}]
    video = Video.create! :link => "Link 4"
    assert_equal 2, video.page, "Calculation of video page is not correct."
  end
end
