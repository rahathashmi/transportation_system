require 'test_helper'

class TripTest < ActiveSupport::TestCase
  
  test "create valid trip" do
    company = create_company
    trip = Trip.new
    trip.start_time = Time.now
    trip.end_time = Time.now + 5.hours
    trip.user = create_user_with_admin(company)
    trip.vehicle = create_vehicle(company)
    trip.company = company
    assert trip.save! 
  end
  
  test "invalid trip without vehicle and user belonging to company" do
    trip = Trip.new
    trip.start_time = Time.now
    trip.user = create_user_with_admin
    trip.vehicle = create_vehicle
    trip.company = create_company
    assert_raises(ActiveRecord::RecordInvalid) {trip.save!}
  end
 
  test "invalid trip with time of vehicle trips overlapping" do
    company = create_company
    trip_1 = Trip.new
    trip_1.start_time = Time.now
    trip_1.end_time = Time.now + 5.hours
    trip_1.user = create_user_with_admin(company)
    trip_1.vehicle = create_vehicle(company)
    trip_1.company = company
    assert trip_1.save!
    company = create_company
    trip_2 = Trip.new
    trip_2.start_time = Time.now - 4.hours
    trip_2.end_time = Time.now + 1.hours # overlapping time
    trip_2.user = create_user_with_admin(company)
    trip_2.vehicle = create_vehicle(company)
    trip_2.company = company
    assert_raises(ActiveRecord::RecordInvalid) {trip_2.save!}
  end

  test "invalid trip without start_time" do
    trip = Trip.new
    assert_raises(ActiveRecord::RecordInvalid) {trip.save!}
  end
  
  test "invalid trip without user" do
    trip = Trip.new
    assert_raises(ActiveRecord::RecordInvalid) {trip.save!}
  end
  
  test "invalid trip without vehicle" do
    trip = Trip.new
    trip.start_time = Time.now
    trip.user = create_user_with_admin
    assert_raises(ActiveRecord::RecordInvalid) {trip.save!}
  end
  
  test "invalid trip without company" do 
    trip = Trip.new
    trip.start_time = Time.now
    trip.user = create_user_with_admin
    trip.vehicle = create_vehicle
    assert_raises(ActiveRecord::RecordInvalid) {trip.save!}
  end
  
  test "delete trip" do
    company = create_company
    trip = Trip.new
    trip.start_time = Time.now
    trip.end_time = Time.now + 5.hours
    trip.user = create_user_with_admin(company)
    trip.vehicle = create_vehicle(company)
    trip.company = company
    assert trip.save!
    assert trip.destroy!
  end
end
