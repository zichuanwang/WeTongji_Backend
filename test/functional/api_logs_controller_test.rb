require 'test_helper'

class ApiLogsControllerTest < ActionController::TestCase
  setup do
    @api_log = api_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_log" do
    assert_difference('ApiLog.count') do
      post :create, api_log: { d: @api_log.d, m: @api_log.m, u: @api_log.u, v: @api_log.v }
    end

    assert_redirected_to api_log_path(assigns(:api_log))
  end

  test "should show api_log" do
    get :show, id: @api_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_log
    assert_response :success
  end

  test "should update api_log" do
    put :update, id: @api_log, api_log: { d: @api_log.d, m: @api_log.m, u: @api_log.u, v: @api_log.v }
    assert_redirected_to api_log_path(assigns(:api_log))
  end

  test "should destroy api_log" do
    assert_difference('ApiLog.count', -1) do
      delete :destroy, id: @api_log
    end

    assert_redirected_to api_logs_path
  end
end
