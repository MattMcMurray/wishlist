require "application_system_test_case"

class WishlistItemsTest < ApplicationSystemTestCase
  setup do
    @wishlist_item = wishlist_items(:one)
  end

  test "visiting the index" do
    visit wishlist_items_url
    assert_selector "h1", text: "Wishlist items"
  end

  test "should create wishlist item" do
    visit wishlist_items_url
    click_on "New wishlist item"

    fill_in "Description", with: @wishlist_item.description
    fill_in "Title", with: @wishlist_item.title
    fill_in "Url", with: @wishlist_item.url
    click_on "Create Wishlist item"

    assert_text "Wishlist item was successfully created"
    click_on "Back"
  end

  test "should update Wishlist item" do
    visit wishlist_item_url(@wishlist_item)
    click_on "Edit this wishlist item", match: :first

    fill_in "Description", with: @wishlist_item.description
    fill_in "Title", with: @wishlist_item.title
    fill_in "Url", with: @wishlist_item.url
    click_on "Update Wishlist item"

    assert_text "Wishlist item was successfully updated"
    click_on "Back"
  end

  test "should destroy Wishlist item" do
    visit wishlist_item_url(@wishlist_item)
    click_on "Destroy this wishlist item", match: :first

    assert_text "Wishlist item was successfully destroyed"
  end
end
