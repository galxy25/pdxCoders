require 'rails_helper'

RSpec.describe "cards/index", type: :view do
  before(:each) do
    FactoryGirl.create(:text_content)
    FactoryGirl.create(:text_content, text: "different")
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
