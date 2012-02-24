require 'test_helper'

class ActivitiesControllerTest < ActionController::TestCase
  setup do
    session.update(:admin => true)
  end

  test "preview" do
    post :preview, :activity => {:year => 2012, :bullets => "Some markdown"}
    assert_response :success
    assert_not_nil assigns(:activity)
  end

  test "new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:activity)
  end

  test "create" do
    # Successful
    assert_difference "Activity.count" do
      post :create, :activity => {:year => 2012, :bullets => "Some markdown"}
    end
    assert_redirected_to about_us_path
    assert_not_nil flash[:notice]

    # Unsuccessful
    assert_no_difference "Activity.count" do
      post :create, :activity => {}
    end
    assert_response :success
    assert_not_nil assigns(:activity)
  end

  test "edit" do
    get :edit, :id => activities(:test).id
    assert_response :success
    assert_not_nil assigns(:activity)
  end

  test "update" do
    # Successful
    put :update, :id => activities(:test).id, :activity => {}
    assert_redirected_to about_us_path
    assert_not_nil flash[:notice]

    # Unsuccessful
    put :update, :id => activities(:test).id, :activity => {:year => nil}
    assert_response :success
    assert_not_nil assigns(:activity)
  end

  test "destroy" do
    assert_difference "Activity.count", -1 do
      delete :destroy, :id => activities(:test).id
    end
    assert_redirected_to about_us_path
    assert_not_nil flash[:notice]
  end

  test "authorization" do
    session.delete(:admin)
    post :preview
    assert_response :unauthorized
    get :new
    assert_response :unauthorized
    post :create
    assert_response :unauthorized
    get :edit
    assert_response :unauthorized
    put :update
    assert_response :unauthorized
    delete :destroy
    assert_response :unauthorized
  end
end
