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
          @user2=FactoryGirl.create(:user, :email => 'newUser@users.com', :username => 'newUser')
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
        @user2=FactoryGirl.create(:user, :email => 'newUser@users.com', :username => 'newUser')
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

    describe '#edit' do
      it 'returns the asked for user when passed an id' do
        @user2=FactoryGirl.create(:user, :email => 'newUser@users.com')
        get :edit, :id =>  @user2.id , :format => :json
        @json_response = JSON.parse(response.body)
        expect(@json_response['id']).to eq @user2.id
      end

      it 'returns the current user when not passed any id' do
        get :edit, :id =>  nil, :format => :json
        @json_response = JSON.parse(response.body)
        expect(@json_response['id']).to eq @user.id
      end
    end

    describe '#update' do
      it 'updates the user with valid new data' do
        patch :update, :id => @user.id, :user => { :email => 'new@new.com', :username => 'newUser' }, :format => :json
        @json_response = JSON.parse(response.body)
        expect(@json_response['email']).to eq 'new@new.com'
      end

      it 'reports an error when trying ot update with invalid data' do
        patch :update, :id => @user.id, :user => { :email => 'new.com', :username => 'newUser' }, :format => :json
        @json_response = JSON.parse(response.body)
        expect(@json_response['status']).to eq 400
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
        expect{get :new, :format => :json}.to change{User.count}.by 0
        @json_response = JSON.parse(response.body)
        expect(@json_response['id']).to be nil
      end
    end

    describe '#create' do
      it 'creates a new user when given valid data' do
        expect{post :create, :user => { :email => 'user@user.com', :password => 'password', :username => 'user' }, :format => :json}.to change{User.count}.by 1
        @json_response = JSON.parse(response.body)
        expect(@json_response['email']).to eq 'user@user.com'
      end

      it 'does not create a user when given invalid data' do
        expect{post :create, :user => { :email => 'bad@bad.com', :password => '2Short', :username => 'bad' }, :format => :json}.to change{User.count}.by 0
        @json_response= JSON.parse(response.body)
        expect(@json_response['status']).to eq 400
      end
    end

    describe '#edit' do
      it 'raises NoMethodError' do
        begin
          get :edit, :id =>  @user.id , :format => :json
        rescue => error
          expect(error.class).to eq(NoMethodError)
        end
      end
    end

    describe '#update' do
      it 'raises NoMethodError' do
        begin
          patch :update, :id =>  1, :email => 'new.com', :username => 'new' :format => :json
        rescue => error
          expect(error.class).to eq(NoMethodError)
        end
      end
    end

  end
end
