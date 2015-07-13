require 'rails_helper'

RSpec.describe Api::CardsController, type: :controller do
    context 'with two valid users and with two cards' do
      let(:user) {FactoryGirl.create(:user)}
      let(:user2) {FactoryGirl.create(:user2)}
      let!(:text_card) {FactoryGirl.create(:text_content, id: 1)}
      let!(:titled_card_content) {FactoryGirl.create(:titled_card_content, id: 2)}

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

        describe '#show' do
          before :each do
            @card = Card.where(content_id: text_card.id).first
            get :show, :id => @card.id , :api_key => user.api_key
            @results = JSON.parse(response.body)
            @returned_card = JSON.parse(@results["card"])
          end

          it 'returns the asked for card' do
            expect(@returned_card["card"]["id"]).to eq @card.id
          end

          it 'returns status 200' do
            expect(@results["status"]).to be 200
          end

          it 'returns 404 when asked for a non-valid card id' do
            get :show, :id => 147 , :api_key => user.api_key
            @results = JSON.parse(response.body)
            expect(@results["status"]).to be 404
          end

        end

        describe '#edit' do
          before :each do
            @card = Card.where(content_id: text_card.id).first
            get :edit , :id => @card.id,
                :content =>  {
                    text: 'New Text'
                },
                :api_key => user.api_key
            @results = JSON.parse(response.body)
            @card = JSON.parse(@results["card"])
            text_card.reload
          end

          it 'updates the card with new text' do
            expect(@card["text_content"]["text"]).to eq "New Text"
            expect(@results["status"]).to eq 204
          end

          it 'updates a title card title and text' do
            @card = Card.where(content_id: titled_card_content.id).first
            get :edit , :id => @card.id,
                :content =>  {
                    text: 'New Text',
                    title: 'New Title'
                },
                :api_key => user.api_key
            @results = JSON.parse(response.body)
            @card = JSON.parse(@results["card"])
            titled_card_content.reload

            expect(@card["titled_card_content"]["text"]).to eq "New Text"
            expect(@card["titled_card_content"]["title"]).to eq "New Title"
            expect(@results["status"]).to eq 204
          end
          it 'returns 404 for a non existent card id' do
            @card = Card.where(content_id: text_card.id).first
            get :edit , :id => Card.count * 3,
                content:  {
                    text: 'New Text'
                },
                :api_key => user.api_key
            @results = JSON.parse(response.body)
            expect(@results["status"]).to eq 404
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

        describe '#show' do
          it 'returns 404 when passed a valid card id' do
            @card = Card.where(content_id: titled_card_content.id).first
            get :show , :id => @card.id, :api_key => 'not a real api key'
            @results = JSON.parse(response.body)
            expect(@results["status"]).to be 403
          end

          it 'returns 404 when passed an invalid card id' do
            get :show , :id => Card.count * 3, :api_key => 'not a real api key'
            @results = JSON.parse(response.body)
            expect(@results["status"]).to be 403
          end
        end

        describe 'edit' do
          it 'returns 404 when passed a valid card id' do
            @card = Card.where(content_id: titled_card_content.id).first
            get :edit , :id => @card.id, :api_key => 'not a real api key'
            @results = JSON.parse(response.body)
            expect(@results["status"]).to be 403
          end

          it 'returns 404 when passed an invalid card id' do
            get :edit , :id => Card.count * 3, :api_key => 'not a real api key'
            @results = JSON.parse(response.body)
            expect(@results["status"]).to be 403
          end
        end
      end
    end
end
