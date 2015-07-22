require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  context 'with two valid cards' do

    let!(:text_card) {FactoryGirl.create(:text_content, id: 1)}
    let!(:titled_card_content) {FactoryGirl.create(:titled_card_content, id: 1)}

    context 'with a signed in user' do

      before :each do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
      end

      describe '#index' do
        it 'should return both cards' do
          get :index , :format => :json
          @results = JSON.parse(response.body)
          expect(@results.count).to be 2
        end
      end

      describe '#show' do
        it 'should return card asked for' do
          @card = Card.where(content_id: text_card.id, content_type_id: 1).first
          get :show , :id => @card.id, :format => :json
          @results = JSON.parse(response.body)
          expect(@results['id']).to eq @card.id
        end
      end

      describe '#create' do
        it 'should create a text card when given valid data' do
          post :create, { cardtext: 'hello world', cardtype: 'text', :format => :json}
          @results = JSON.parse(response.body)
          expect(TextContent.find(@results['content_id']).text).to eq "hello world"
        end

        it 'creates a new card titled card in the database' do
          expect{post :create,  {:cardtext => "hello world",
                                 :cardtitle => "new title",
                                 :cardtype => 'rule',
                                 :format => :json} }.to change{Card.all.count}.by 1
        end
      end

      describe '#update' do

      end
    end
  end

end
