require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      email: "test-#{SecureRandom.hex(8)}@example.com",
      password: "password",
      password_confirmation: "password",
      name: "Test User"
    )
    sign_in @user

    @category = Category.create!(name: "Test Category")
  end

  test "should get show" do
    get category_url(@category)
    assert_response :success
  end
end
