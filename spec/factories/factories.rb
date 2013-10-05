FactoryGirl.define do
  sequence :email do |n|
    "testemail#{n}@fortunerookie.com"
  end

  sequence :password do |n|
    "1234567#{n}"
  end

  factory :user do
    email
    password
    balance 100_00
  end

  factory :transaction do
    association :buyer, factory: :user
    association :seller, factory: :user

    price 10_00
    shares 1
  end
end
