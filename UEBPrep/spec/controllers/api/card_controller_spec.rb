require 'rails_helper'

RSpec.describe Api::CardsController, type: :controller do
    context 'with two valid users and with two cards' do
      let(:user) {FactoryGirl.create(:user)}
      let(:user2) {FactoryGirl.create(:user2)}
      let!(:text_card) {FactoryGirl.create(:text_content)}
      let!(:titled_card_content) {FactoryGirl.create(:titled_card_content)}

      context 'with a valid api key' do
        describe '#index' do
          before :each do
            get :index ,:api_key => user.api_key
            @results = JSON.parse(response.body)
          end

          it 'returns status 200' do
            expect(@results["status"]).to be 200
          end
          it 'returns both users' do
            expect(@results["count"]).to be 2
          end
        end
      end

      context 'with an invalid api key' do
        describe '#index' do
          it 'with an invalid api key returns 404' do
            get :index ,:api_key => 'not a real api key'
            @results = JSON.parse(response.body)
            expect(@results["status"]).to be 403
          end
        end
      end
    end
end
