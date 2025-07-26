require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get admin_dashboard_url
    assert_response :success
  end

  test "should get posts" do
    get admin_posts_url
    assert_response :success
  end

  test "should get comments" do
    get admin_comments_url
    assert_response :success
  end
end
