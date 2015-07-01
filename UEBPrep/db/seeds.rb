# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


text_content = TextContent.create(text: 'text content woohooo!')
content_type = ContentType.create(name: 'TextContent')
Card.create(content_type_id: content_type.id, content_id: text_content.id)

titled_card_content = TitledCardContent.create(title: 'super cool title', text: 'double super cool text')
content_type = ContentType.create(name: 'TitledCardContent')
Card.create(content_type_id: content_type.id, content_id: text_content.id)

if Rails.env.test? || Rails.env.development?
  john_doe = User.find_by(email: "customer@example.com") || FactoryGirl.create(:user, email: "customer@example.com")
  jane_doe = User.find_by(email: "adminr@example.com") || FactoryGirl.create(:user, email: "admin@example.com")
end
