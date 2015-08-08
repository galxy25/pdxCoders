require 'rails_helper'

RSpec.describe PlaylistsController, type: :controller do
  context 'with a signed in user' do
    let(:user) {FactoryGirl.create(:user)}
    let(:playlist_name) { 'Valid Name'}
    before :each do
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

    describe 'GET #cards' do
      before (:each) do
        @playlist = FactoryGirl.create(:playlist, :user => user)
        @card1 = FactoryGirl.create(:text_content).card
        @card2 = FactoryGirl.create(:titled_card_content).card
        @playlist.add_card(@card1)
        @playlist.add_card(@card2)

        get :cards, { :id => @playlist.id, :format => :json }
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
          expect(@cards.first['card']['id']).to eq(@card1.id)
          expect(@cards.second['card']['id']).to eq(@card2.id)
        end

        it 'returns cards with a valid order' do
          expect(@cards.first['card']['order']).to be 1
          expect(@cards.second['card']['order']).to be 2
        end
      end
    end
  end
end
