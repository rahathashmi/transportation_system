require 'test_helper'

class VehicleTest < ActiveSupport::TestCase
  
  test "invalid vehicle without company" do
    vehicle = Vehicle.new
    assert_raises(ActiveRecord::RecordInvalid) {vehicle.save!}
  end
  
  test "create vehicle" do
    vehicle = Vehicle.new
    vehicle.company = Company.create!()
    assert vehicle.save!
  end
  
  test "delete vehicle" do 
    vehicle = Vehicle.new
    vehicle.company = Company.create!()
    vehicle.save!
    assert vehicle.destroy!
  end
end
