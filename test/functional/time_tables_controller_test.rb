require 'test_helper'

class TimeTablesControllerTest < ActionController::TestCase
  setup do
    @time_table = time_tables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:time_tables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create time_table" do
    assert_difference('TimeTable.count') do
      post :create, time_table: @time_table.attributes
    end

    assert_redirected_to time_table_path(assigns(:time_table))
  end

  test "should show time_table" do
    get :show, id: @time_table
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @time_table
    assert_response :success
  end

  test "should update time_table" do
    put :update, id: @time_table, time_table: @time_table.attributes
    assert_redirected_to time_table_path(assigns(:time_table))
  end

  test "should destroy time_table" do
    assert_difference('TimeTable.count', -1) do
      delete :destroy, id: @time_table
    end

    assert_redirected_to time_tables_path
  end
end
