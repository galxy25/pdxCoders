require 'spec_helper'

RSpec.describe TitledCardContent, type: :model do

  describe "Create" do
    it "creates a corresponding Card entry" do
      content = TitledCardContent.new(title: "content title", text: "content text")
      expect{content.save}.to change{Card.count}.by 1
    end

    it "creates a card entry with the proper content_type_id and content_id" do
      content = TitledCardContent.new(title: "content title", text: "content text")
      content.save
      card = Card.find_by content_id: content.id
      expect(card.content_id).to equal content.id
    end

    it "does not duplicate entries" do
      content = FactoryGirl.create(:titled_card_content)
      expect {
        content2 = FactoryGirl.create(:titled_card_content)
      }.to raise_error ActiveRecord::RecordInvalid
    end

    it "allows for duplicate entries when text is different" do
      expect {
        content = FactoryGirl.create(:titled_card_content)
        content2 = TitledCardContent.create(title: content.title, text: "totally different text")
      }.to change { [TitledCardContent.count, Card.count] }.by [2, 2]
    end

    it "allows for dusplicate entries when title is different" do
      expect {
        content = FactoryGirl.create(:titled_card_content)
        content2 = TitledCardContent.create(title: "totally different title", text: content.text)
      }.to change { [TitledCardContent.count, Card.count] }.by [2, 2]
    end
  end
end
