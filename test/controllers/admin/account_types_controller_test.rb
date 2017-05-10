require 'test_helper'

class Admin::AccountTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_account_type = admin_account_types(:one)
  end

  test "should get index" do
    get admin_account_types_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_account_type_url
    assert_response :success
  end

  test "should create admin_account_type" do
    assert_difference('Admin::AccountType.count') do
      post admin_account_types_url, params: { admin_account_type: { created_at: @admin_account_type.created_at, name: @admin_account_type.name, price: @admin_account_type.price, space: @admin_account_type.space, updated_at: @admin_account_type.updated_at } }
    end

    assert_redirected_to admin_account_type_url(Admin::AccountType.last)
  end

  test "should show admin_account_type" do
    get admin_account_type_url(@admin_account_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_account_type_url(@admin_account_type)
    assert_response :success
  end

  test "should update admin_account_type" do
    patch admin_account_type_url(@admin_account_type), params: { admin_account_type: { created_at: @admin_account_type.created_at, name: @admin_account_type.name, price: @admin_account_type.price, space: @admin_account_type.space, updated_at: @admin_account_type.updated_at } }
    assert_redirected_to admin_account_type_url(@admin_account_type)
  end

  test "should destroy admin_account_type" do
    assert_difference('Admin::AccountType.count', -1) do
      delete admin_account_type_url(@admin_account_type)
    end

    assert_redirected_to admin_account_types_url
  end
end
