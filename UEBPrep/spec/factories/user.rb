FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    username 'example'
    password 'password'
  end

  factory :user2, class: User do
    email 'example2@example.com'
    username 'example2'
    password 'password'
  end
end
