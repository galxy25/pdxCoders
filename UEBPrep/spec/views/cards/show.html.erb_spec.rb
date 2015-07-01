require 'rails_helper'

RSpec.describe "cards/show", type: :view do
  before(:each) do
    TextContent.create(text: "stuff")
    @card = Card.first
  end

  it "renders attributes in <p>" do
    render
  end
end
