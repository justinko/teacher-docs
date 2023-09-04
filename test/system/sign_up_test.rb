require "application_system_test_case"

class SignUpTest < ApplicationSystemTestCase
  test "invalid form" do
    visit new_user_url
    fill_in "Email", with: users(:john).email
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    assert_no_difference "User.count", "Session.count" do
      click_on "Create Account"
      assert_text "Email has already been taken"
      assert_text "Password is too short"
    end
  end

  test "valid form" do
    visit new_user_url
    fill_in "Email", with: "john.doe@example.com"
    fill_in "Password", with: "password12345"
    fill_in "Password confirmation", with: "password12345"
    assert_difference(
      -> { User.count } => 1,
      -> { Session.count } => 1
    ) do
      click_on "Create Account"
      assert_selector "h2", text: "Documents"
    end
  end
end
