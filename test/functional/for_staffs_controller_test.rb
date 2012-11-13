require 'test_helper'

class ForStaffsControllerTest < ActionController::TestCase
  setup do
    @for_staff = for_staffs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:for_staffs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create for_staff" do
    assert_difference('ForStaff.count') do
      post :create, for_staff: @for_staff.attributes
    end

    assert_redirected_to for_staff_path(assigns(:for_staff))
  end

  test "should show for_staff" do
    get :show, id: @for_staff
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @for_staff
    assert_response :success
  end

  test "should update for_staff" do
    put :update, id: @for_staff, for_staff: @for_staff.attributes
    assert_redirected_to for_staff_path(assigns(:for_staff))
  end

  test "should destroy for_staff" do
    assert_difference('ForStaff.count', -1) do
      delete :destroy, id: @for_staff
    end

    assert_redirected_to for_staffs_path
  end
end
