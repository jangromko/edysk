require 'test_helper'

class Concerns::PublicControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get concerns_public_controller_home_url
    assert_response :success
  end

end
