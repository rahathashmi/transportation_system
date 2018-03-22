require 'test_helper'

class TripTest < ActiveSupport::TestCase
  test "invalid trip without start_time" do
    user = User.new
    assert_raises(ActiveRecord::RecordInvalid) {user.save!}
  end
  
  test "invalid trip without user" do
    trip = Trip.new
    assert_raises(ActiveRecord::RecordInvalid) {trip.save!}
  end
  
  test "invalid trip without vehicle" do 
  end
  
  test "invalid trip without company" do 
    
  end
  
  test "invalid trip without vehicle and user belonging to trip" do 
  end
  
  test "invalid trip with time of vehicle trips overlapping" do 
    
  end
  test "create trip" do
  end
  
  test "delete trip" do
    
  end
end
