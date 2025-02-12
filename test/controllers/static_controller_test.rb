require "test_helper"

class StaticControllerTest < ActionDispatch::IntegrationTest
  test "should get privacy_policy" do
    get static_privacy_policy_url
    assert_response :success
  end
end
