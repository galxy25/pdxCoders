require 'rails_helper'

RSpec.describe PlaylistsController, type: :controller do
  context 'with a signed in user' do
    let(:user) {FactoryGirl.create(:user)}
    let(:userTwo) {FactoryGirl.create(:user, email: 'new@new.com', username: 'UserTwo')}
    let(:playlist_name) { 'Valid Name'}
    let(:playlist) {FactoryGirl.create(:playlist)}
    let(:playlistTwo) {FactoryGirl.create(:playlist)}

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

    describe "#show" do
      before :each do
        playlist.user = user 
        playlist.save!
        playlist.reload

        get :show , :id => playlist.id , :format => :json
      end

      it "returns the asked for playlist" do
        expect(assigns(:playlist).id).to eq playlist.id
        expect(assigns(:playlist).user_id).to eq user.id
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

end
