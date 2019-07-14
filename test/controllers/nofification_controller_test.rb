require 'test_helper'

class NofificationControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get nofification_show_url
    assert_response :success
  end

end
