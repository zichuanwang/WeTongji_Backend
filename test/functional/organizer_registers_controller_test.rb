require 'test_helper'

class OrganizerRegistersControllerTest < ActionController::TestCase
  setup do
    @organizer_register = organizer_registers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organizer_registers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create organizer_register" do
    assert_difference('OrganizerRegister.count') do
      post :create, organizer_register: @organizer_register.attributes
    end

    assert_redirected_to organizer_register_path(assigns(:organizer_register))
  end

  test "should show organizer_register" do
    get :show, id: @organizer_register
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @organizer_register
    assert_response :success
  end

  test "should update organizer_register" do
    put :update, id: @organizer_register, organizer_register: @organizer_register.attributes
    assert_redirected_to organizer_register_path(assigns(:organizer_register))
  end

  test "should destroy organizer_register" do
    assert_difference('OrganizerRegister.count', -1) do
      delete :destroy, id: @organizer_register
    end

    assert_redirected_to organizer_registers_path
  end
end
