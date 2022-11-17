require "test_helper"

class TradeControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get trade_top_url
    assert_response :success
  end
end
