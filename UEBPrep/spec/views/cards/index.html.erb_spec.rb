require 'rails_helper'

RSpec.describe "cards/index", type: :view do
  before(:each) do
    TextContent.create(text: "stuff")
    TextContent.create(text: "stuff2")
    @card = Card.first
    assign(:cards, [
      Card.first,
      Card.last
    ])
  end

  it "renders a list of cards" do
    render
  end
end
