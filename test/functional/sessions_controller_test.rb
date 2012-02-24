require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "new" do
    get :new
    assert_response :success
    assert_select "form[action=#{login_path}]" do
      assert_select "input[name=username]"
      assert_select "input[name=password]"
    end
  end

  test "create" do
    # Successful
    admin = CapellaJuris::Application.config.admin
    post :create, :username => admin.username, :password => admin.password
    assert_response :redirect
    assert_not_nil flash[:notice]
    assert session[:admin], "Admin is not logged in after login."

    # Unsuccessful
    session.delete(:admin)
    post :create, :username => "Kenny", :password => "McCormick"
    assert_response :success
    assert_not_nil flash[:error]
    assert !session[:admin], "Admin is logged in after he typed wrong username and password."
  end

  test "destroy" do
    delete :destroy
    assert_response :redirect
    assert !session[:admin], "Admin is still logged in after logout."
  end
end
