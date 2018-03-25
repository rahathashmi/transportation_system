ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def create_company
    company = Company.create!()
    company
  end
  
  def create_vehicle(company = nil)
    vehicle = Vehicle.create!(company: company.present? ? company : create_company)
    vehicle
  end
  
  def create_role_admin
    role = Role.find_or_initialize_by(name: "admin")
    role.save!
    role
  end
  def create_role_read
    role = Role.find_or_initialize_by(name: "read")
    role.save!
    role
  end
  
  def create_user_with_admin(company = nil)
    user = User.find_or_initialize_by(email: 'test_admin_1@test.com')
    if user.new_record?
      user.password = "testing"
      user.company = company.present? ? company : create_company
      user.save!
    end
    unless user.role.present?
      role = create_role_admin
      user.role = role
      user.save!
    end
    user
  end
  
  def create_user_with_read(company = nil)
    user = User.find_or_initialize_by(email: 'test_read@test.com')
    if user.new_record?
      user.password = "testing"
      user.company = company.present? ? company : create_company
      user.save!
    end
    unless user.role.present?
      role = create_role_read
      user.role = role
      user.save!
    end
    user
  end
end
