require "application_system_test_case"

class ListSharesTest < ApplicationSystemTestCase
  setup do
    @list_share = list_shares(:one)
  end

  test "visiting the index" do
    visit list_shares_url
    assert_selector "h1", text: "List shares"
  end

  test "should create list share" do
    visit list_shares_url
    click_on "New list share"

    fill_in "List", with: @list_share.list_id
    fill_in "Type", with: @list_share.type
    fill_in "User", with: @list_share.user_id
    click_on "Create List share"

    assert_text "List share was successfully created"
    click_on "Back"
  end

  test "should update List share" do
    visit list_share_url(@list_share)
    click_on "Edit this list share", match: :first

    fill_in "List", with: @list_share.list_id
    fill_in "Type", with: @list_share.type
    fill_in "User", with: @list_share.user_id
    click_on "Update List share"

    assert_text "List share was successfully updated"
    click_on "Back"
  end

  test "should destroy List share" do
    visit list_share_url(@list_share)
    click_on "Destroy this list share", match: :first

    assert_text "List share was successfully destroyed"
  end
end
