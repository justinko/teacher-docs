require "application_system_test_case"

class AuthenticationTest < ApplicationSystemTestCase
  test "sign up, sign in, and sign out" do
    email, password = "john.doe@example.com", "password12345"
    visit new_user_url
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password
    assert_difference(
      -> { User.count } => 1,
      -> { Session.count } => 1
    ) do
      click_on "Create Account"
      assert_selector "h2", text: "Documents"
    end
    assert_changes -> { Session.count } do
      click_on "Sign out"
      assert_selector "h2", text: "Sign in"
    end
    assert_changes -> { Session.count } do
      fill_in "Email", with: email
      fill_in "Password", with: password
      click_on "Sign in"
      assert_selector "h2", text: "Documents"
    end
  end
end
