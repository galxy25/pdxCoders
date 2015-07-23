require 'rails_helper'

RSpec.describe "playlists.rb/new", type: :view do
  before(:each) do
    assign(:playlist, Playlist.new())
  end

  it "renders new playlist form" do
    render

    assert_select "form[action=?][method=?]", playlists_path, "post" do
    end
  end
end
