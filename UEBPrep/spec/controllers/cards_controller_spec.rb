require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  context 'with two valid cards' do

    let!(:text_card) {FactoryGirl.create(:text_content, id: 1)}
    let!(:titled_card_content) {FactoryGirl.create(:titled_card_content, id: 1)}
    let(:citation) {"My Citation"}

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

        it "should allow you to add a citation to a card" do
          post :create, { cardtext: 'hello world', cardtype: 'text', citation: citation, :format => :json}
          @results = JSON.parse(response.body)
          expect(@results['citation']).to eq citation
        end

        it 'creates a new card titled card in the database' do
          expect{post :create,  {:cardtext => "hello world",
                                 :cardtitle => "new title",
                                 :cardtype => 'rule',
                                 :format => :json} }.to change{Card.all.count}.by 1
        end
      end

      describe '#update' do
        it "updates an existing card with new valid data" do
          @card = Card.where(content_id: text_card.id, content_type_id: 1).first
          update_params = {:cardtype => 'text',
                           :cardtext => 'New Text',
                           :id => @card.id
                          }
          patch :update, :id => @card.id, :cardtype => 'text', :text => 'New Text' , :format => :json
          text_card.reload
          expect(text_card.text).to eq 'New Text'
        end

      end

      describe '#destroy' do
        it "deletes the specified card from the database" do
            @card = Card.where(content_id: text_card.id, content_type_id: 1).first
            deleted_id = @card.id
            delete :destroy, :id => @card.id
            expect{Card.find(deleted_id)}.to raise_error ActiveRecord::RecordNotFound
        end

      end

    end

  end

end
