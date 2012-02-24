require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "rework_photo" do
    photo_with_annoying_title = %(<a title="Some annoying flickr title" href="link_to_somewhere"><img src="photo.jpg"></a>)
    assert_equal %(<a href="link_to_somewhere" class="img"><img src="photo.jpg"></a>), rework_photo(photo_with_annoying_title)
    assert_nothing_raised(NoMethodError) { rework_photo(nil) }
  end
end
