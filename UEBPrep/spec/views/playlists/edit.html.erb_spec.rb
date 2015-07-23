require 'rails_helper'

RSpec.describe "playlists.rb/edit", type: :view do
  before(:each) do
    @playlist = assign(:playlist, Playlist.create!())
  end

  it "renders the edit playlist form" do
    render

    assert_select "form[action=?][method=?]", playlist_path(@playlist), "post" do
    end
  end
end
