require "test_helper"

class EventControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get event_top_url
    assert_response :success
  end
end
