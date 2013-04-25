require 'test_helper'

class VideoBookmarksControllerTest < ActionController::TestCase
  setup do
    @video_bookmark = video_bookmarks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:video_bookmarks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create video_bookmark" do
    assert_difference('VideoBookmark.count') do
      post :create, video_bookmark: { person_id: @video_bookmark.person_id, pos: @video_bookmark.pos, session_id: @video_bookmark.session_id, type: @video_bookmark.type }
    end

    assert_redirected_to video_bookmark_path(assigns(:video_bookmark))
  end

  test "should show video_bookmark" do
    get :show, id: @video_bookmark
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @video_bookmark
    assert_response :success
  end

  test "should update video_bookmark" do
    put :update, id: @video_bookmark, video_bookmark: { person_id: @video_bookmark.person_id, pos: @video_bookmark.pos, session_id: @video_bookmark.session_id, type: @video_bookmark.type }
    assert_redirected_to video_bookmark_path(assigns(:video_bookmark))
  end

  test "should destroy video_bookmark" do
    assert_difference('VideoBookmark.count', -1) do
      delete :destroy, id: @video_bookmark
    end

    assert_redirected_to video_bookmarks_path
  end
end
