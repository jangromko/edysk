require 'test_helper'

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = admin_users(:one)
  end

  test "should get index" do
    get admin_users_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_user_url
    assert_response :success
  end

  test "should create admin_user" do
    assert_difference('Admin::User.count') do
      post admin_users_url, params: { admin_user: { account_type_id: @admin_user.account_type_id, created_at: @admin_user.created_at, email: @admin_user.email, login: @admin_user.login, password: @admin_user.password, salt: @admin_user.salt, updated_at: @admin_user.updated_at } }
    end

    assert_redirected_to admin_user_url(Admin::User.last)
  end

  test "should show admin_user" do
    get admin_user_url(@admin_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_user_url(@admin_user)
    assert_response :success
  end

  test "should update admin_user" do
    patch admin_user_url(@admin_user), params: { admin_user: { account_type_id: @admin_user.account_type_id, created_at: @admin_user.created_at, email: @admin_user.email, login: @admin_user.login, password: @admin_user.password, salt: @admin_user.salt, updated_at: @admin_user.updated_at } }
    assert_redirected_to admin_user_url(@admin_user)
  end

  test "should destroy admin_user" do
    assert_difference('Admin::User.count', -1) do
      delete admin_user_url(@admin_user)
    end

    assert_redirected_to admin_users_url
  end
end
