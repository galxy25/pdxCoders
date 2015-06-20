# require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do

  describe "Create" do
    it "Creates a user when given valid input" do
      u=User.new(email: "test@test.com", password: "abcd123")
      expect{u.save}.to change{User.count}.by 1
    end

    it "Does not create a user when given an invalid email" do
      u=User.new(email: "testbad", password: "abcd123")
      expect{u.save}.to change{User.count}.by 0
    end

    it "Does not create a user when given an invalid password" do
      u=User.new(email: "test@test.com", password: "abc")
      expect{u.save}.to change{User.count}.by 0
    end
  end

  describe "Destroy" do
    it "should soft delete the user" do
      user = FactoryGirl.create(:user)

      user.destroy

      expect { User.find(user.id) }.to raise_error ActiveRecord::RecordNotFound
      expect { User.with_deleted.find(user.id) }.to_not raise_error
    end
  end
end
