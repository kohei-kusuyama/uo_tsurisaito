require "test_helper"

class Public::FishingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_fishing_index_url
    assert_response :success
  end

  test "should get create" do
    get public_fishing_create_url
    assert_response :success
  end
end
