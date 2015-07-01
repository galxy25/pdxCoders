require 'spec_helper'

RSpec.describe TextContent, type: :model do

  describe "Create" do
    it "Creates a corresponding Card entry" do
      content = TextContent.new(text: "content text")
      expect{content.save}.to change{Card.count}.by 1
    end

    it "Creates a card entry with the proper content_type_id and content_id" do
      content = TextContent.new(text: "content text")
      content.save
      card = Card.find_by content_id: content.id
      expect(card.content_id).to equal content.id
    end
  end
end
