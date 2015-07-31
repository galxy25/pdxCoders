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

  end

end
