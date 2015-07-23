require 'spec_helper'

RSpec.describe Playlist, type: :model do

  let(:user) { FactoryGirl.create(:user) }
  let(:content) { FactoryGirl.create(:text_content, created_by: user.id) }
  let(:card) { content.card }

  describe "Create" do

    it "creates a playlist for a specified user" do
      expect {
        FactoryGirl.create(:playlist, user: user)
      }.to change { Playlist.count }.by 1
    end

    it "correctly associates a playlist to a specified user" do
      playlist = FactoryGirl.create(:playlist, user: user)
      expect(playlist.user.id).to eq(user.id)
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

  describe "Add" do
    it "allows a card to be added" do
      playlist = FactoryGirl.build(:playlist, user: user)
      expect {
        playlist.save
        playlist.add(card)
      }.to change { playlist.cards.count }.by 1
    end

  end

  describe "Remove" do
    
    it "removes a card from the playlist" do
      playlist = FactoryGirl.build(:playlist, user: user)
      playlist.save
      playlist.add(card)
      expect {
        playlist.remove(card)
      }.to change { playlist.cards.count }.by -1
    end

    it "does not remove the card entry from the db" do
      playlist = FactoryGirl.build(:playlist, user: user)
      playlist.save
      playlist.add(card)
      expect {
        playlist.remove(card)
      }.to_not change { Card.count }
    end
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
