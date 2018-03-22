require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "invalid user without email" do
    user = User.new
    assert_raises(ActiveRecord::RecordInvalid) {user.save!}
  end
  
  test "invalid user without password" do
    user = User.new
    user.email = "user_test@test.com"
    assert_raises(ActiveRecord::RecordInvalid) {user.save!}
  end
  
  test "invalid user without company" do 
    user = User.new
    user.email = "user_test@test.com"
    user.password = "testing"
    assert_raises(ActiveRecord::RecordInvalid) {user.save!}
  end
  
  test "create user" do
    user = User.new
    user.email = "user_test@test.com"
    user.password = "testing"
    user.company = Company.first || Company.create!()
    assert(user.save!, "User created")
  end
  
  test "delete user" do
    user = User.create!(email: "user_test@test.com",password: "testing", company: Company.create!())
    assert user.destroy!
  end
end
