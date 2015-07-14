require 'spec_helper'

RSpec.describe Card, type: :model do

  let(:user) { FactoryGirl.create(:user) }
  let(:content) { FactoryGirl.create(:text_content, created_by: user.id) }
  let(:card) { content.card }

  describe "Create" do

    it "does not initialize a card with a non-existant content" do
      expect {
        content.destroy
        card.save
      }.to raise_error { ActiveRecord::RecordNotFound }
    end

    # it "does not allow a duplicate card entry for the same content" do
    #   card.save
    #   expect {
    #     new_card = Card.new(content_type_id: 1, content_id: content.id, created_by: user.id)
    #     new_card.save
    #   }.to change{ Card.count }.by 0
    # end
    
    # TODO: think of more tests.
    # Kind of awkward because of the necessity for a card entry to be created
    # by a content object on save.
  end

  describe "Destroy" do
    it "ensures that a card's content is also destroyed" do
      card.destroy
      expect {
        TextContent.find(content.id)
      }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
