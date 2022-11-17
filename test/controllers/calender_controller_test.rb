require "test_helper"

class CalenderControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get calender_top_url
    assert_response :success
  end
end
