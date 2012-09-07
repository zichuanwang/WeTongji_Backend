require 'test_helper'

class SensitivesControllerTest < ActionController::TestCase
  setup do
    @sensitive = sensitives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sensitives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sensitive" do
    assert_difference('Sensitive.count') do
      post :create, sensitive: @sensitive.attributes
    end

    assert_redirected_to sensitive_path(assigns(:sensitive))
  end

  test "should show sensitive" do
    get :show, id: @sensitive
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sensitive
    assert_response :success
  end

  test "should update sensitive" do
    put :update, id: @sensitive, sensitive: @sensitive.attributes
    assert_redirected_to sensitive_path(assigns(:sensitive))
  end

  test "should destroy sensitive" do
    assert_difference('Sensitive.count', -1) do
      delete :destroy, id: @sensitive
    end

    assert_redirected_to sensitives_path
  end
end
