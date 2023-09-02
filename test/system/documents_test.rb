require "application_system_test_case"

class DocumentsTest < ApplicationSystemTestCase
  test "upload and delete" do
    user = users(:bob)

    # TODO: create "backdoor" auth for testing
    visit new_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1234"
    click_on "Sign in"

    assert_text "No documents"

    assert_changes -> { user.documents.count } do
      attach_file "document_file", file_fixture("example.md")
      click_on "Upload"
      assert_text "example.md"
      assert_text "31 Bytes"
    end
    assert_changes -> { user.documents.count } do
      click_on "Delete"
      assert_text "No documents"
    end
  end

  test "viewing a document does not require authentication" do
    doc = documents(:markdown)
    visit document_path(doc.signed_id)
    assert_text doc.file.filename
    assert_text "Download"
    # TODO: test download
  end
end
