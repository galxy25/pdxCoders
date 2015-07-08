require 'spec_helper'

RSpec.describe TextContent, type: :model do

  let(:user) { FactoryGirl.create(:user) }
  let(:content) { FactoryGirl.create(:text_content, :created_by => user.id) }

  describe "Create" do

    it "Creates a corresponding Card entry" do
      expect {
        content.save
      }.to change { [TextContent.count, Card.count] }.by [1, 1]
    end

    it "Creates a card entry with the proper content_type_id and content_id" do
      content.save
      card = Card.find_by content_id: content.id
      expect(card.content_id).to equal content.id
    end

    it "doesn't create a TextContent entry when the associated Card entry fails to save" do
      expect {
        expect {
          allow(Card).to recieve(:save) { false }
          content.save
        }.to raise_error { ActiveRecord::RecordInvalid }
      }.to_not change { [TextContent.count, Card.count] }
    end

    it "does not duplicate entries" do
      expect {
        content.save
        content.save
      }.to change { [TextContent.count, Card.count] }.by [1, 1]
    end

    it "creates multiple non-identical entries" do
      expect {
        content.save
        different_content = FactoryGirl.build(:text_content)
        different_content.text = 'stuff'
        different_content.save
      }.to change { [TextContent.count, Card.count] }.by [2, 2]
    end


  end
end
