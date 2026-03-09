require "test_helper"

class GroceriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      email: "test-#{SecureRandom.hex(8)}@example.com",
      password: "password",
      password_confirmation: "password",
      name: "Test User"
    )
    sign_in @user
  end

  test "should get index" do
    get groceries_url
    assert_response :success
  end
end
