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

content_type = ContentType.create(name: 'TextContent')
text_content = TextContent.create(text: 'text content woohooo!')

content_type = ContentType.create(name: 'TitledCardContent')
titled_card_content = TitledCardContent.create(title: 'super cool title', text: 'double super cool text')


