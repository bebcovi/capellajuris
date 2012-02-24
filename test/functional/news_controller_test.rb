require 'test_helper'

class NewsControllerTest < ActionController::TestCase
  setup do
    session.update(:admin => true)
  end

  test "preview" do
    post :preview, :news => {:title => "Title", :text => "Text"}
    assert_response :success
    assert_not_nil assigns(:news)
  end

  test "new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:news)
  end

  test "create" do
    # Successful
    assert_difference "News.count" do
      post :create, :news => {:title => "Title 1", :text => "Text 1"}
    end
    assert_redirected_to home_path
    assert_not_nil flash[:notice]

    # Unsuccessful
    assert_no_difference "News.count" do
      post :create, :news => {}
    end
    assert_response :success
    assert_not_nil assigns(:news)
  end

  test "edit" do
    get :edit, :id => news(:test).id
    assert_response :success
    assert_not_nil assigns(:news)
  end

  test "successful update" do
    # Successful
    put :update, :id => news(:test).id, :news => {}
    assert_redirected_to home_path
    assert_not_nil flash[:notice]

    # Unsuccessful
    put :update, :id => news(:test).id, :news => {:title => ""}
    assert_response :success
    assert_not_nil assigns(:news)
  end

  test "destroy" do
    assert_difference "News.count", -1 do
      delete :destroy, :id => news(:for_delete).id
    end
    assert_redirected_to home_path
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
