require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      email: "test-#{SecureRandom.hex(8)}@example.com",
      password: "password",
      password_confirmation: "password",
      name: "Test User"
    )
    sign_in @user
  end

  test "should get show" do
    get cart_url
    assert_response :success
  end
end
