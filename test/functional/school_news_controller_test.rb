require 'test_helper'

class SchoolNewsControllerTest < ActionController::TestCase
  setup do
    @school_news = school_news(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:school_news)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create school_news" do
    assert_difference('SchoolNews.count') do
      post :create, school_news: @school_news.attributes
    end

    assert_redirected_to school_news_path(assigns(:school_news))
  end

  test "should show school_news" do
    get :show, id: @school_news
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @school_news
    assert_response :success
  end

  test "should update school_news" do
    put :update, id: @school_news, school_news: @school_news.attributes
    assert_redirected_to school_news_path(assigns(:school_news))
  end

  test "should destroy school_news" do
    assert_difference('SchoolNews.count', -1) do
      delete :destroy, id: @school_news
    end

    assert_redirected_to school_news_index_path
  end
end
