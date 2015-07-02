require 'spec_helper'

RSpec.describe TextContent, type: :model do

  describe "Create" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @text = 'content text'
      @content = TextContent.new(text: @text, created_by: @user.id)
    end

    it "Creates a corresponding Card entry" do
      expect {
        @content.save
      }.to change { [TextContent.count, Card.count] }.by [1, 1]
    end

    it "Creates a card entry with the proper content_type_id and content_id" do
      @content.save
      card = Card.find_by content_id: @content.id
      expect(card.content_id).to equal @content.id
    end

    it "does not duplicate entries" do
      expect {
        @content.save
        content2 = TextContent.new(text: @text, created_by: @user.id)
        content2.save
      }.to change { [TextContent.count, Card.count] }.by [1, 1]
    end

    it "creates multiple non-identical entries" do
      expect {
        @content.save
        content2 = TextContent.new(text: 'different text', created_by: @user.id)
        content2.save
      }.to change { [TextContent.count, Card.count] }.by [2, 2]
    end
  end
end
