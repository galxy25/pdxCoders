require 'spec_helper'

RSpec.describe TitledCardContent, type: :model do

  describe "Create" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @text = 'content text'
      @title = 'content title'
      @content = TitledCardContent.new(title: @title, text: @text, created_by: @user.id)
    end

    it "creates a corresponding Card entry" do
      expect{ @content.save }.to change{ [TitledCardContent.count, Card.count] }.by [1, 1]
    end

    it "creates a card entry with the proper content_type_id and content_id" do
      @content.save
      card = Card.find_by content_id: @content.id
      expect(card.content_id).to equal @content.id
    end

    it "does not duplicate entries" do
      expect {
        @content.save
        @content.save
      }.to change { [TitledCardContent.count, Card.count] }.by [1, 1]
    end

    it "allows for duplicate entries when text is different" do
      expect {
        @content.save
        content2 = TitledCardContent.create(title: @title, text: "totally different text", created_by: @user.id)
      }.to change { [TitledCardContent.count, Card.count] }.by [2, 2]
    end

    it "allows for dusplicate entries when title is different" do
      expect {
        @content.save
        content2 = TitledCardContent.create(title: "totally different title", text: @text, created_by: @user.id)
      }.to change { [TitledCardContent.count, Card.count] }.by [2, 2]
    end
  end
end
