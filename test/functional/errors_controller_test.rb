require 'test_helper'

class ErrorsControllerTest < ActionController::TestCase
  test "404" do
    get :not_found
    assert_response :not_found
  end
end
