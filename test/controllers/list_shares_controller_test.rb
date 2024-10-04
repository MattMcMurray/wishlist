require "test_helper"

class ListSharesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @list_share = list_shares(:one)
  end

  test "should get index" do
    get list_shares_url
    assert_response :success
  end

  test "should get new" do
    get new_list_share_url
    assert_response :success
  end

  test "should create list_share" do
    assert_difference("ListShare.count") do
      post list_shares_url, params: { list_share: { list_id: @list_share.list_id, type: @list_share.type, user_id: @list_share.user_id } }
    end

    assert_redirected_to list_share_url(ListShare.last)
  end

  test "should show list_share" do
    get list_share_url(@list_share)
    assert_response :success
  end

  test "should get edit" do
    get edit_list_share_url(@list_share)
    assert_response :success
  end

  test "should update list_share" do
    patch list_share_url(@list_share), params: { list_share: { list_id: @list_share.list_id, type: @list_share.type, user_id: @list_share.user_id } }
    assert_redirected_to list_share_url(@list_share)
  end

  test "should destroy list_share" do
    assert_difference("ListShare.count", -1) do
      delete list_share_url(@list_share)
    end

    assert_redirected_to list_shares_url
  end
end
