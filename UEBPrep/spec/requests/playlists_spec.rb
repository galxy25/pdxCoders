require 'rails_helper'

RSpec.describe "Playlists", type: :request do
  describe "GET /playlists.rb" do
    it "works! (now write some real specs)" do
      get playlists_path
      expect(response).to have_http_status(200)
    end
  end
end
