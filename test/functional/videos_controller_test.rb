require 'test_helper'

class VideosControllerTest < ActionController::TestCase
  setup do
    session.update(:admin => true)
  end

  test "new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:video)
  end

  test "create" do
    # Successful
    assert_difference "Video.count" do
      post :create, :video => {:title => "Video", :link => "Video link"}
    end
    assert_redirected_to videos_path(:page => Video.find_by_title("Video").page)
    assert_not_nil flash[:notice]

    # Unsuccessful
    assert_no_difference "Video.count" do
      post :create, :video => {}
    end
    assert_response :success
    assert_not_nil assigns(:video)
  end

  test "destroy" do
    assert_difference "Video.count", -1 do
      delete :destroy, :id => videos(:test).id
    end
    assert_redirected_to videos_path
    assert_not_nil flash[:notice]
  end

  test "authorization" do
    session.delete(:admin)
    get :new
    assert_response :unauthorized
    post :create
    assert_response :unauthorized
    delete :destroy
    assert_response :unauthorized
  end
end
