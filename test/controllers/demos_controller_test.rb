require 'test_helper'

class DemosControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get demos_show_url
    assert_response :success
  end

  test "should get index" do
    get demos_index_url
    assert_response :success
  end

end
