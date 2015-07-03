require 'spec_helper'

RSpec.describe TitledCardContent, type: :model do

  let(:user) { FactoryGirl.create(:user) }
  let(:content) { FactoryGirl.create(:titled_card_content, :created_by => user.id) }

  describe "Create" do

    it "creates a corresponding Card entry" do
      expect {
        content.save
      }.to change{ [TitledCardContent.count, Card.count] }.by [1, 1]
    end

    it "creates a card entry with the proper content_type_id and content_id" do
      content.save
      card = Card.find_by content_id: content.id
      expect(card.content_id).to equal content.id
    end

    it "does not duplicate entries" do
      expect {
        content.save
        content.save
      }.to change { [TitledCardContent.count, Card.count] }.by [1, 1]
    end

    it "allows for duplicate entries when text is different" do
      expect {
        content.save
        content2 = FactoryGirl.create(:titled_card_content, text: 'different text')
      }.to change { [TitledCardContent.count, Card.count] }.by [2, 2]
    end

    it "allows for dusplicate entries when title is different" do
      expect {
        content.save
        content2 = FactoryGirl.create(:titled_card_content, title: 'totally different title')
      }.to change { [TitledCardContent.count, Card.count] }.by [2, 2]
    end
  end
end
