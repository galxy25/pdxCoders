require 'rails_helper'

RSpec.describe PlaylistsController, type: :controller do

  let (:user) { FactoryGirl.create(:user) }

  let(:valid_attributes) {
    { :name => 'Playlist Name', :user => user.id }
  }

  let(:valid_update_attributes) {
    { :name => 'New Playlist Name' }
  }

  let(:invalid_attributes) {
    { :name => '', :user => '' }
  }

  let(:valid_session) { {} }

  context 'with a valid signed in user' do

    before (:each) do
      sign_in(user)
    end

    describe '#cards' do
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
        it 'returns all cards' do
          expect(@json_response.count).to be 2
          expect(@json_response.first['id']).to eq @card1.id
          expect(@json_response.second['id']).to eq @card2.id
        end
      end
    end
  end

  describe "GET #index" do
    it "assigns all playlists as @playlists" do
      playlist = Playlist.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:playlists)).to eq([playlist])
    end
  end

  describe "GET #show" do
    it "assigns the requested playlist as @playlist" do
      playlist = Playlist.create! valid_attributes
      get :show, {:id => playlist.to_param}, valid_session
      expect(assigns(:playlist)).to eq(playlist)
    end
  end

  describe "GET #new" do
    it "assigns a new playlist as @playlist" do
      get :new, {}, valid_session
      expect(assigns(:playlist)).to be_a_new(Playlist)
    end
  end

  describe "GET #edit" do
    it "assigns the requested playlist as @playlist" do
      playlist = Playlist.create! valid_attributes
      get :edit, {:id => playlist.to_param}, valid_session
      expect(assigns(:playlist)).to eq(playlist)
    end
  end

  describe "GET #cards" do
    it "assigns the requested playlist as @playlist" do
      playlist = Playlist.create! valid_attributes
      get :cards, {:id => playlist.to_param}, valid_session
      expect(assigns(:playlist)).to eq(playlist)
    end

    it "returns"
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Playlist" do
        expect {
          post :create, {:playlist => valid_attributes}, valid_session
        }.to change(Playlist, :count).by(1)
      end

      it "assigns a newly created playlist as @playlist" do
        post :create, {:playlist => valid_attributes}, valid_session
        expect(assigns(:playlist)).to be_a(Playlist)
        expect(assigns(:playlist)).to be_persisted
      end

      it "redirects to the created playlist" do
        post :create, {:playlist => valid_attributes}, valid_session
        expect(response).to redirect_to(Playlist.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved playlist as @playlist" do
        post :create, {:playlist => invalid_attributes}, valid_session
        expect(assigns(:playlist)).to be_a_new(Playlist)
      end

      it "re-renders the 'new' template" do
        post :create, {:playlist => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested playlist" do
        playlist = Playlist.create! valid_attributes
        put :update, {:id => playlist.to_param, :playlist => new_attributes}, valid_session
        playlist.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested playlist as @playlist" do
        playlist = Playlist.create! valid_attributes
        put :update, {:id => playlist.to_param, :playlist => valid_attributes}, valid_session
        expect(assigns(:playlist)).to eq(playlist)
      end

      it "redirects to the playlist" do
        playlist = Playlist.create! valid_attributes
        put :update, {:id => playlist.to_param, :playlist => valid_attributes}, valid_session
        expect(response).to redirect_to(playlist)
      end
    end

    context "with invalid params" do
      it "assigns the playlist as @playlist" do
        playlist = Playlist.create! valid_attributes
        put :update, {:id => playlist.to_param, :playlist => invalid_attributes}, valid_session
        expect(assigns(:playlist)).to eq(playlist)
      end

      it "re-renders the 'edit' template" do
        playlist = Playlist.create! valid_attributes
        put :update, {:id => playlist.to_param, :playlist => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested playlist" do
      playlist = Playlist.create! valid_attributes
      expect {
        delete :destroy, {:id => playlist.to_param}, valid_session
      }.to change(Playlist, :count).by(-1)
    end

    it "redirects to the playlists list" do
      playlist = Playlist.create! valid_attributes
      delete :destroy, {:id => playlist.to_param}, valid_session
      expect(response).to redirect_to(playlists_url)
    end
  end

end
