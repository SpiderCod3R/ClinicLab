require 'test_helper'

class Painel::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get painel_dashboard_index_url
    assert_response :success
  end

end
