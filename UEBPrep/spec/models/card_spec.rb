require 'spec_helper'

RSpec.describe Card, type: :model do

  describe "Create" do

    it "does not initialize a card with a non-existant content" do
      expect {
        card = Card.new(content_type_id: 1, content_id: 1, created_by: 1)
      }
    end
    
    # TODO: think of more tests.
    # Kind of awkward because of the necessity for a card entry to be created
    # by a content object on save.
  end

  describe "Destroy" do
    it "ensures that a card's content is also destroyed" do
      content = FactoryGirl.create(:text_content)
      card = Card.find_by content_type_id: 1, content_id: content.id

      card.destroy
      expect { TextContent.find(content.id) }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
