FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    password 'password'
  end

  factory :user2, class: User do
    email 'example2@example.com'
    password 'password'
  end
end
