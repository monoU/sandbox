require 'test_helper'

class ExpansionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get expansions_index_url
    assert_response :success
  end

  test "should get new" do
    get expansions_new_url
    assert_response :success
  end

end
