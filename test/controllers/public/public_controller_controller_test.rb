require 'test_helper'

class Public::PublicControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get public_public_controller_home_url
    assert_response :success
  end

end
