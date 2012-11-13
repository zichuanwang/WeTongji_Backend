require 'test_helper'

class ClubNewsControllerTest < ActionController::TestCase
  setup do
    @club_news = club_news(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:club_news)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create club_news" do
    assert_difference('ClubNews.count') do
      post :create, club_news: @club_news.attributes
    end

    assert_redirected_to club_news_path(assigns(:club_news))
  end

  test "should show club_news" do
    get :show, id: @club_news
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @club_news
    assert_response :success
  end

  test "should update club_news" do
    put :update, id: @club_news, club_news: @club_news.attributes
    assert_redirected_to club_news_path(assigns(:club_news))
  end

  test "should destroy club_news" do
    assert_difference('ClubNews.count', -1) do
      delete :destroy, id: @club_news
    end

    assert_redirected_to club_news_index_path
  end
end
