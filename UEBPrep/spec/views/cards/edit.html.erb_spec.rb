require 'rails_helper'

RSpec.describe "cards/edit", type: :view do
  before(:each) do
    TextContent.create(text: "stuff")
    @card = Card.first
  end

  it "renders the edit card form" do
    render

    assert_select "form[action=?][method=?]", card_path(@card), "post" do
    end
  end
end
