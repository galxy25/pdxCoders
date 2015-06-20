require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do

    context "with two users" do
      let!(:user) {FactoryGirl.create(:user)}
      let!(:user2) {FactoryGirl.create(:user, :email => "some@some.com")}

      describe "#index" do
        before(:each) do
          get :index
          @results = JSON.parse(response.body)
        end

        it "returns status 200" do
          expect(@results["status"]).to be 200
        end

        it "returns all users" do
          expect(@results["users"].count).to be 2
        end
      end

      describe "#show" do
        before(:each) do
          get :show , :id => user2.id
          @results = JSON.parse(response.body)
        end

        it "returns status 200 for a valid user" do
          expect(@results["status"]).to be 200
        end

        it "returns the user when given an existing user id" do
          expect(@results["user"]["email"]).to match user2.email
        end

        it "raises an error when asked for non-existent user" do
          begin
            get :show, :id => 42
          rescue => error
            expect(error.class).to be ActiveRecord::RecordNotFound
          end
        end
      end
    end

end
