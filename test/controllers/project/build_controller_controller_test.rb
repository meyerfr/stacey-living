require 'test_helper'

class Project::BuildControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get project_build_controller_show_url
    assert_response :success
  end

  test "should get update" do
    get project_build_controller_update_url
    assert_response :success
  end

end
