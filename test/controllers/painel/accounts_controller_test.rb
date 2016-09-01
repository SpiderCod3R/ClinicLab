require 'test_helper'

class Painel::AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get painel_accounts_index_url
    assert_response :success
  end

end
