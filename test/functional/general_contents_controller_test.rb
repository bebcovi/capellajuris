require 'test_helper'

class GeneralContentsControllerTest < ActionController::TestCase
  setup do
    session.update(:admin => true)
  end

  test "preview" do
    post :preview, :general_content => {:title => "Title", :text => "Text"}
    assert_response :success
    assert_not_nil assigns(:general_content)
  end

  test "edit" do
    get :edit, :id => general_contents(:intro).id
    assert_response :success
    assert_not_nil assigns(:general_content)
  end

  test "update" do
    # Successful
    put :update, :id => general_contents(:intro).id, :general_content => {}
    assert_response :redirect
    assert_not_nil flash[:notice]

    # Unsuccessful
    put :update, :id => general_contents(:intro).id, :general_content => {:title => ""}
    assert_response :success
    assert_not_nil assigns(:general_content)
  end

  test "authorization" do
    session.delete(:admin)
    post :preview
    assert_response :unauthorized
    get :edit
    assert_response :unauthorized
    put :update
    assert_response :unauthorized
  end
end
