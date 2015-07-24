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

  content_type = ContentType.find_by(name: TextContent) || ContentType.create(name: 'TextContent')
  text_content = TextContent.find_by(text: 'text content woohooo!') || TextContent.create(text: 'text content woohooo!', created_by: john_doe.id)

  content_type2 = ContentType.find_by(name: 'TitledCardContent') || ContentType.create(name: 'TitledCardContent')
  titled_card_content = TitledCardContent.find_by(title: 'super cool title') || TitledCardContent.create(title: 'super cool title', text: 'double super cool text', created_by: jane_doe.id)


  content_type3 = ContentType.find_by(name: 'ImageContent') || ContentType.create(name: 'ImageContent')

  playlist = Playlist.create(name: 'This is a playlist')
  playlist.user = john_doe
  playlist.cards.push(text_content.card)
  playlist.cards.push(titled_card_content.card)
  playlist.save

end




