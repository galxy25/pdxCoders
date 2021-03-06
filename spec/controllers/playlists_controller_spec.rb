require 'rails_helper'

RSpec.describe PlaylistsController, type: :controller do
  context 'with a signed in user' do
    let(:user) {FactoryGirl.create(:user)}
    let(:userTwo) {FactoryGirl.create(:user, email: 'new@new.com', username: 'UserTwo')}
    let(:playlist_name) { 'Valid Name'}
    let(:playlist) {FactoryGirl.create(:playlist)}
    let(:playlistTwo) {FactoryGirl.create(:playlist)}
    let!(:text_card) {FactoryGirl.create(:text_content, id: 1)}
    let!(:titled_card_content) {FactoryGirl.create(:titled_card_content, id: 1)}

    before :each do
      playlist.add_card(text_card.card)
      playlist.add_card(titled_card_content.card)
      sign_in user
    end

    describe "GET #new" do
      before :each do
        get :new, {name: playlist_name}
      end

      it "creates a playlist with the given name" do
        expect(assigns(:playlist).name).to eq playlist_name
      end

      it "creates a playlist assigned to the signed in user" do
        expect(assigns(:playlist).user_id).to eq user.id
      end
    end

    context 'playlists with users' do
      before :each do
        playlist.user = user
        playlist.save!
        playlist.reload
      end

      describe '#remove_card_playlist' do
        before :each do
          @card = text_card.card
          post :remove_card_playlist , :id => playlist.id , :to_remove => @card.id, :format => :json
          @results = JSON.parse(response.body)
        end

        it 'removes the card from the specifified playlist' do
          expect(playlist.cards).to_not include(@card)
        end

        it 'does not delete the card' do
          expect{(Card.find(@card.id))}.to_not raise_error
        end

      end
      describe "#show" do
        before :each do
          get :show , :id => playlist.id , :format => :json
          @results = JSON.parse(response.body)
        end

        it "returns the asked for playlist" do
          expect(assigns(:playlist).id).to eq playlist.id
          expect(assigns(:playlist).user_id).to eq user.id
        end

        it "returns the first card of the playlist" do
          expect(@results["current_card"]["id"]).to eq playlist.cards.first.id
        end

        it "returns the next card passed an id of a card in the playlist and direciton of Forward" do
          get :show, :id => playlist.id, :play_params => { display_card_id: playlist.cards.first.id, direction: "Forward" }, :format => :json
          @results = JSON.parse(response.body)
          expect(@results["current_card"]["id"]).to eq playlist.cards.second.id
        end

        it "returns the previous card when passed an id of a card in the playlist and direciton of Back"  do
          get :show, :id => playlist.id, :play_params => { display_card_id: playlist.cards.second.id, direction: "Back" }, :format => :json
          @results = JSON.parse(response.body)
          expect(@results["current_card"]["id"]).to eq playlist.cards.first.id
        end

        it "returns 404 when asked for a non-existent playlist" do
          get :show , :id => (Playlist.count + 1) , :format => :json
          @results = JSON.parse(response.body)
          expect(@results["status"]).to eq 404
        end

        context "with a playlist that does not belong to the current user" do
          before :each do
            playlistTwo.user = userTwo
            playlistTwo.save!
            playlist.reload

            get :show , :id => playlistTwo.id , :format => :json
            @results = JSON.parse(response.body)
          end

          it "returns 403 when asked for a playlist not created by the current user" do
            expect(@results["status"]).to eq 403
          end
        end
      end
    end

    describe 'GET #cards' do
      before (:each) do
        get :cards, { :id => playlist.id, :format => :json }
        @json_response = JSON.parse(response.body)
      end

      describe 'with a valid playlist with two cards' do
        before (:each) do
          @cards = JSON.parse(@json_response['card'])
        end

        it 'returns all cards' do
          expect(@cards.count).to be 2
        end

        it 'has the right cards' do
          expect(@cards.first['card']['id']).to eq(text_card.card.id)
          expect(@cards.second['card']['id']).to eq(titled_card_content.card.id)
        end

        it 'returns cards with a valid order' do
          expect(@cards.first['card']['order']).to eq(1)
          expect(@cards.second['card']['order']).to eq(2)
        end
      end
    end
  end
end
