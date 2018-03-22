# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

company = Company.new
company.save!
user = User.find_or_initialize_by(email: 'testing_db@test.com')
user.update!(email: 'testing_db@test.com', password: 'testing', company: company)

user_test = User.find_or_initialize_by(email: 'test_user_db@test.com')
user_test.update!(email: 'test_user_db@test.com', password: 'testing', company: company)

role_admin = Role.find_or_initialize_by(name: 'admin')
role_admin.save!

role_read = Role.find_or_initialize_by(name: 'read')
role_read.save!

user.role = role_admin
user.save!

user_test.role = role_read
user_test.save!

user.role = role_admin
user.save!

user_test.role = role_read
user_test.save!

vehicle = Vehicle.find_or_initialize_by(company: company)
vehicle.save!

vehicle_2 = Vehicle.create!(company: company)
vehicle_3 = Vehicle.create!(company: company)
vehicle_4 = Vehicle.create!(company: company)

Doorkeeper::Application.create!(:name => 'test', :redirect_uri => 'urn:ietf:wg:oauth:2.0:oob')
trip = Trip.create!(vehicle: vehicle, company: company, user: user, start_time: Time.now, end_time: Time.now + 2.hours)
trip = Trip.create!(vehicle: vehicle, company: company, user: user_test, start_time: Time.now + 2.hours, end_time: Time.now + 3.hours, distance: "50")
trip = Trip.create!(vehicle: vehicle, company: company, user: user, start_time: Time.now + 3.hours + 5.minutes, end_time: Time.now + 4.hours)

