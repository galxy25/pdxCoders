# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.test? || Rails.env.development?
  john_doe = User.find_by(email: "customer@example.com") || FactoryGirl.create(:user, email: "customer@example.com", username: "johnDoe")
  jane_doe = User.find_by(email: "adminr@example.com") || FactoryGirl.create(:user, email: "admin@example.com", username: "janeDoe")

  content_type = ContentType.find_by(name: 'TextContent') || ContentType.create(name: 'TextContent')
  text_content = TextContent.find_by(text: 'Text Card 1') || TextContent.create(text: 'The text for Text Card 1!', created_by: john_doe.id)

  content_type2 = ContentType.find_by(name: 'TitledCardContent') || ContentType.create(name: 'TitledCardContent')
  titled_card_content1 = TitledCardContent.find_by(title: 'Title Card 1') || TitledCardContent.create(title: 'TitleCard1', text: 'The text for Title Card 1', created_by: jane_doe.id)
  titled_card_content2 = TitledCardContent.find_by(title: 'Title Card 2') || TitledCardContent.create(title: 'TitleCard2', text: 'The text for Title Card 2', created_by: jane_doe.id)
  titled_card_content3 = TitledCardContent.find_by(title: 'Title Card 3') || TitledCardContent.create(title: 'TitleCard3', text: 'The text for Title Card 3', created_by: jane_doe.id)

  #content_type3 = ContentType.find_by(name: 'ImageContent') || ContentType.create(name: 'ImageContent')


  playlist = Playlist.create(name: 'This is a playlist')
  playlist.user = john_doe
  playlist.cards.push(text_content.card)
  playlist.cards.push(titled_card_content1.card)
  playlist.cards.push(titled_card_content2.card)
  playlist.cards.push(titled_card_content3.card)
  playlist.save

end




