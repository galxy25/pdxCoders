require 'rails_helper'

RSpec.describe Api::ApiController, type: :controller do

  context "With one user account" do
    let!(:user1){FactoryGirl.create(:user)}

    describe "#login" do
        it "returns 202 when given a valid user api key" do
            post :login , api_key: user1.api_key
            results = JSON.parse(response.body)
            expect(results["status"]).to equal 202
        end

        it "returns 403 when trying to log in with invalid user credentials " do
            post :login , api_key: 'a_made_up_key'
            results = JSON.parse(response.body)
            expect(results["status"]).to equal 403
        end
    end

  end
end
