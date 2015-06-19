require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do

    let(:user) {FactoryGirl.create(:user)}
    let(:user2) {FactoryGirl.create(:user, :email => "some@some.com")}

    describe "index" do
      it "returns all users" do
        binding.pry
        get :index
        binding.pry
        expect(response.count).to be 2
      end
    end

    describe "#show" do
      it "returns the specified user" do
        get :show,  id: user2.id
        binding.pry
        expect(response.count).to be 1
      end
    end

end
