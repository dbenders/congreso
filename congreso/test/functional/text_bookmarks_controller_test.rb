require 'test_helper'

class TextBookmarksControllerTest < ActionController::TestCase
  setup do
    @text_bookmark = text_bookmarks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:text_bookmarks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create text_bookmark" do
    assert_difference('TextBookmark.count') do
      post :create, text_bookmark: { length: @text_bookmark.length, pos: @text_bookmark.pos }
    end

    assert_redirected_to text_bookmark_path(assigns(:text_bookmark))
  end

  test "should show text_bookmark" do
    get :show, id: @text_bookmark
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @text_bookmark
    assert_response :success
  end

  test "should update text_bookmark" do
    put :update, id: @text_bookmark, text_bookmark: { length: @text_bookmark.length, pos: @text_bookmark.pos }
    assert_redirected_to text_bookmark_path(assigns(:text_bookmark))
  end

  test "should destroy text_bookmark" do
    assert_difference('TextBookmark.count', -1) do
      delete :destroy, id: @text_bookmark
    end

    assert_redirected_to text_bookmarks_path
  end
end
