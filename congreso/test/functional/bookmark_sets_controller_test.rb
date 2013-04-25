require 'test_helper'

class BookmarkSetsControllerTest < ActionController::TestCase
  setup do
    @bookmark_set = bookmark_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookmark_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bookmark_set" do
    assert_difference('BookmarkSet.count') do
      post :create, bookmark_set: { name: @bookmark_set.name, session_id: @bookmark_set.session_id, typ: @bookmark_set.typ }
    end

    assert_redirected_to bookmark_set_path(assigns(:bookmark_set))
  end

  test "should show bookmark_set" do
    get :show, id: @bookmark_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bookmark_set
    assert_response :success
  end

  test "should update bookmark_set" do
    put :update, id: @bookmark_set, bookmark_set: { name: @bookmark_set.name, session_id: @bookmark_set.session_id, typ: @bookmark_set.typ }
    assert_redirected_to bookmark_set_path(assigns(:bookmark_set))
  end

  test "should destroy bookmark_set" do
    assert_difference('BookmarkSet.count', -1) do
      delete :destroy, id: @bookmark_set
    end

    assert_redirected_to bookmark_sets_path
  end
end
