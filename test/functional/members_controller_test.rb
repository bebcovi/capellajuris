require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  setup do
    session.update(:admin => true)
  end

  test "gui" do
    get :gui
    assert_response :success
    assert_not_nil assigns(:members)
  end

  test "new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:member)
  end

  test "create" do
    # Successful
    assert_difference "Member.count" do
      post :create, :member => {:first_name => "Kenny", :last_name => "McCormick", :voice => "T"}
    end
    assert_redirected_to edit_members_path
    assert_not_nil flash[:notice]

    # Unsuccessful
    assert_no_difference "Member.count" do
      post :create, :member => {}
    end
    assert_response :success
    assert_not_nil assigns(:member)
  end

  test "destroy" do
    assert_difference "Member.count", -1 do
      delete :destroy, :id => members(:kenny).id
    end
  end

  test "authorization" do
    session.delete(:admin)
    get :gui
    assert_response :unauthorized
    get :new
    assert_response :unauthorized
    post :create
    assert_response :unauthorized
    delete :destroy
    assert_response :unauthorized
  end
end
