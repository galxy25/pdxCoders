require 'rails_helper'

RSpec.describe "playlists.rb/index", type: :view do
  before(:each) do
    assign(:'playlists.rb', [
      Playlist.create!(),
      Playlist.create!()
    ])
  end

  it "renders a list of playlists.rb" do
    render
  end
end
