require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  context 'with a valid signed in user' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in(@user)
    end

    describe '#index' do
      describe 'with two users' do
        before(:each) do
          @user2=FactoryGirl.create(:user, :email => 'newUser@users.com')
          get :index , :format => :json
          @json_response = JSON.parse(response.body)

        end
        it 'returns all users' do
          expect(@json_response.count).to be 2
          #TODO: Make this less implementatin depenedent, like fuzzy matching versus
          #using the fact that (currently) users are returned FILO
          expect(@json_response.first['id']).to eq @user2.id
          expect(@json_response.second['id']).to eq @user.id
        end
      end
    end

    describe '#show' do
      it 'returns the current logged in user' do
        get :show, :id =>  @user.slug , :format => :json
        @json_response = JSON.parse(response.body)
        expect(@json_response['id']).to eq @user.id
        expect(@json_response['api_key']).to eq @user.api_key
      end

      it 'still returns the current user even when you request a different user' do
        @user2=FactoryGirl.create(:user, :email => 'newUser@users.com')
        get :show, :id =>  @user2.slug , :format => :json
        @json_response = JSON.parse(response.body)
        expect(@json_response['id']).to eq @user.id
        expect(@json_response['api_key']).to eq @user.api_key
      end
    end

    describe '#new' do
      it 'builds a generic user' do
        expect{get :new, :format => :json}.to change{User.all.count}.by 0
        @json_response = JSON.parse(response.body)
        expect(@json_response['id']).to be nil
      end
    end
  end

  context 'without a valid signed in user' do
    describe '#index' do
      it 'raises NoMethodError' do
        begin
          get :index
        rescue => error
          expect(error.class).to eq(NoMethodError)
        end
      end
    end

    describe '#show' do
      it 'raises NoMethodError' do
        begin
          get :show, :id =>  @user.slug , :format => :json
        rescue => error
          expect(error.class).to eq(NoMethodError)
        end
      end
    end

    describe '#new' do
      it 'builds a generic user' do
        expect{get :new, :format => :json}.to change{User.all.count}.by 0
        @json_response = JSON.parse(response.body)
        expect(@json_response['id']).to be nil
      end
    end
  end
end
