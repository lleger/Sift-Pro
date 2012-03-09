require 'test_helper'

class TwitterControllerTest < ActionController::TestCase
  test "should get authorize" do
    get :authorize
    assert_response :success
  end

  test "should get callback" do
    get :callback
    assert_response :success
  end

  test "should get tweet" do
    get :tweet
    assert_response :success
  end

end
