# Read about factories at https://github.com/thoughtbot/factory_girl

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
    balance 10000
  end
end
