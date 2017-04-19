require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get drive" do
    get main_drive_url
    assert_response :success
  end

end
