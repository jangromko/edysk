require 'test_helper'

class FileControllerTest < ActionDispatch::IntegrationTest
  test "should get download" do
    get file_download_url
    assert_response :success
  end

  test "should get shared" do
    get file_shared_url
    assert_response :success
  end

  test "should get remove" do
    get file_remove_url
    assert_response :success
  end

  test "should get name" do
    get file_name_url
    assert_response :success
  end

  test "should get share" do
    get file_share_url
    assert_response :success
  end

  test "should get move" do
    get file_move_url
    assert_response :success
  end

  test "should get copy" do
    get file_copy_url
    assert_response :success
  end

  test "should get upload" do
    get file_upload_url
    assert_response :success
  end

  test "should get unshare" do
    get file_unshare_url
    assert_response :success
  end

end
