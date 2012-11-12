require 'test_helper'

class AroundsControllerTest < ActionController::TestCase
  setup do
    @around = arounds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:arounds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create around" do
    assert_difference('Around.count') do
      post :create, around: @around.attributes
    end

    assert_redirected_to around_path(assigns(:around))
  end

  test "should show around" do
    get :show, id: @around
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @around
    assert_response :success
  end

  test "should update around" do
    put :update, id: @around, around: @around.attributes
    assert_redirected_to around_path(assigns(:around))
  end

  test "should destroy around" do
    assert_difference('Around.count', -1) do
      delete :destroy, id: @around
    end

    assert_redirected_to arounds_path
  end
end
