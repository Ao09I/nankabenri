require "test_helper"

class CalendarControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get calendar_top_url
    assert_response :success
  end
end
