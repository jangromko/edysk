require 'test_helper'

class DirControllerTest < ActionDispatch::IntegrationTest
  test "should get shared" do
    get dir_shared_url
    assert_response :success
  end

  test "should get move" do
    get dir_move_url
    assert_response :success
  end

  test "should get show" do
    get dir_show_url
    assert_response :success
  end

  test "should get new" do
    get dir_new_url
    assert_response :success
  end

  test "should get remove" do
    get dir_remove_url
    assert_response :success
  end

  test "should get name" do
    get dir_name_url
    assert_response :success
  end

  test "should get unshare" do
    get dir_unshare_url
    assert_response :success
  end

end
