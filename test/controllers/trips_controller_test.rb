require 'test_helper'

class TripsControllerTest < ActionDispatch::IntegrationTest

  test "check unauthorized access to post trip call" do
    post api_trips_path
    assert_response :unauthorized
  end
  
  test "check unauthorized access to get trip call" do
    get api_trips_path
    assert_response :unauthorized
  end
  
  test "check unauthorized access to get trips summary call" do
    get api_trips_summary_path
    assert_response :unauthorized
  end
  test "should post login request" do
    user = create_user_with_read
    post oauth_token_path params: { email: user.email, password: user.password, grant_type: 'password'}
    assert_response :success
  end
  
  test "should get token in login response" do
    user = create_user_with_admin
    post oauth_token_path params: { email: user.email, password: user.password, grant_type: 'password'}
    response = JSON.parse(@response.body)
    user_access_token = response['access_token']
    assert_not_nil(user_access_token, "Authentication token generated" )
  end
  
  test "admin user should have ability to get trips" do
    user = create_user_with_admin
    ability = Ability.new(user)
    assert ability.can? :index, Trip
  end

  test "read user should have ability to get trips" do
    user = create_user_with_read
    ability = Ability.new(user)
    assert ability.can? :index, Trip
  end
  test "read user should not have ability to create trips" do
    user = create_user_with_read
    ability = Ability.new(user)
    assert_not ability.can? :create, Trip
  end
end
