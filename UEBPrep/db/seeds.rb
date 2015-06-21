# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.test? || Rails.env.development?
  john_doe = User.find_by(email: "customer@example.com") || FactoryGirl.create(:user, email: "customer@example.com")
  jane_doe = User.find_by(email: "adminr@example.com") || FactoryGirl.create(:user, email: "admin@example.com")
end
