require "application_system_test_case"

class AuthenticationTest < ApplicationSystemTestCase
  test "sign in and out" do
    visit new_session_url
    fill_in "Email", with: "whatever@test.com"
    fill_in "Password", with: "password"
    assert_no_difference "Session.count" do
      click_on "Sign in"
      assert_text "Invalid email or password"
    end
    fill_in "Email", with: users(:john).email
    fill_in "Password", with: "password1234"
    assert_difference -> { Session.count } => 1 do
      click_on "Sign in"
      assert_selector "h2", text: "Documents"
    end
    assert_difference -> { Session.count } => -1 do
      click_on "Sign out"
      assert_selector "h2", text: "Sign in"
    end
  end
end
