require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get player_rank" do
    get :player_rank
    assert_response :success
  end

  test "should get ranking" do
    get :ranking
    assert_response :success
  end

end
