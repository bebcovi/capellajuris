require 'test_helper'

class AudiosControllerTest < ActionController::TestCase
  setup do
    session.update(:admin => true)
  end

  test "manage" do
    get :manage
    assert_response :success
    assert_not_nil assigns(:audio)
  end

  test "create" do
    # Successful
    aac = fixture_file_upload "files/audio1.aac"
    ogg = fixture_file_upload "files/audio1.ogg"
    assert_difference "Audio.count" do
      post :create, :audio => {:title => "Title", :aac => aac, :ogg => ogg}
    end
    assert_redirected_to manage_audios_path
    assert_not_nil flash[:notice]

    # Unsuccessful
    assert_no_difference "Audio.count" do
      post :create, :audio => {}
    end
    assert_response :success
    assert_not_nil assigns(:audio)
  end

  test "destroy" do
    assert_difference "Audio.count", -1 do
      delete :destroy, :id => audios(:test).id
    end
    assert_redirected_to manage_audios_path
    assert_not_nil flash[:notice]
  end

  test "authorization" do
    session.delete(:admin)
    get :manage
    assert_response :unauthorized
    post :create
    assert_response :unauthorized
    delete :destroy
    assert_response :unauthorized
  end
end
