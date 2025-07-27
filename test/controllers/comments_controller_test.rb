require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get comments_edit_path
    assert_response :success
  end
end
