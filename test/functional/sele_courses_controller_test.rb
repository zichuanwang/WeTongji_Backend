require 'test_helper'

class SeleCoursesControllerTest < ActionController::TestCase
  setup do
    @sele_course = sele_courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sele_courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sele_course" do
    assert_difference('SeleCourse.count') do
      post :create, sele_course: @sele_course.attributes
    end

    assert_redirected_to sele_course_path(assigns(:sele_course))
  end

  test "should show sele_course" do
    get :show, id: @sele_course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sele_course
    assert_response :success
  end

  test "should update sele_course" do
    put :update, id: @sele_course, sele_course: @sele_course.attributes
    assert_redirected_to sele_course_path(assigns(:sele_course))
  end

  test "should destroy sele_course" do
    assert_difference('SeleCourse.count', -1) do
      delete :destroy, id: @sele_course
    end

    assert_redirected_to sele_courses_path
  end
end
