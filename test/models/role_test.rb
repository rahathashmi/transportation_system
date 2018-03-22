require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "create role" do
    role = Role.new
    role.name = "user"
    assert role.save!
  end
  
  test "delete role" do
    role = Role.new
    role.name = "user"
    role.save!
    assert role.destroy!
  end
  
  test "invalid role" do 
    role = Role.new
    assert_raises(ActiveRecord::RecordInvalid) {role.save!}
  end
end
