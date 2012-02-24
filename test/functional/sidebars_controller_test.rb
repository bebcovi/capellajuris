require 'test_helper'

class SidebarsControllerTest < ActionController::TestCase
  setup do
    session.update(:admin => true)
  end

  test "edit" do
    get :edit
    assert_response :success
    assert_not_nil assigns(:sidebar)
  end

  test "update" do
    # Successful
    put :update, :sidebar => {}
    assert_redirected_to home_path
    assert_not_nil flash[:notice]

    # Unsuccessful
    put :update, :sidebar => {:video_title => ""}
    assert_response :success
    assert_not_nil assigns(:sidebar)
  end

  test "authorization" do
    session.delete(:admin)
    get :edit
    assert_response :unauthorized
    put :update
    assert_response :unauthorized
  end
end
