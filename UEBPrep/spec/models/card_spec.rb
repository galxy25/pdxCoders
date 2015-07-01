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
end
