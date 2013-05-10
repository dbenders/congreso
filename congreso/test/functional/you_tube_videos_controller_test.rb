require 'test_helper'

class YouTubeVideosControllerTest < ActionController::TestCase
  setup do
    @you_tube_video = you_tube_videos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:you_tube_videos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create you_tube_video" do
    assert_difference('YouTubeVideo.count') do
      post :create, you_tube_video: { id: @you_tube_video.id, name: @you_tube_video.name, num: @you_tube_video.num, session_id: @you_tube_video.session_id }
    end

    assert_redirected_to you_tube_video_path(assigns(:you_tube_video))
  end

  test "should show you_tube_video" do
    get :show, id: @you_tube_video
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @you_tube_video
    assert_response :success
  end

  test "should update you_tube_video" do
    put :update, id: @you_tube_video, you_tube_video: { id: @you_tube_video.id, name: @you_tube_video.name, num: @you_tube_video.num, session_id: @you_tube_video.session_id }
    assert_redirected_to you_tube_video_path(assigns(:you_tube_video))
  end

  test "should destroy you_tube_video" do
    assert_difference('YouTubeVideo.count', -1) do
      delete :destroy, id: @you_tube_video
    end

    assert_redirected_to you_tube_videos_path
  end
end
