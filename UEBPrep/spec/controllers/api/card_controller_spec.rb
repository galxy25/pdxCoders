require 'rails_helper'

RSpec.describe Api::CardsController, type: :controller do
  context 'with a signed in user' do
    let(:user) {FactoryGirl.create(:user)}
    let(:text_card) {FactoryGirl.create(:text_content)}
    let(:titled_card_content) {FactoryGirl.create(:titled_card_content)}

    before :each do

    end

    describe '#index' do
      it 'with an invalid api key returns 404' do
        get :index ,:api_key => 'not a real api key'
        @results = JSON.parse(response.body)
        expect(@results["status"]).to be 403
      end
    end
  end

end