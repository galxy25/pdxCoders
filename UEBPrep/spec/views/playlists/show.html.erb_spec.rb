require 'rails_helper'

RSpec.describe "playlists.rb/show", type: :view do
  before(:each) do
    @playlist = assign(:playlist, Playlist.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
