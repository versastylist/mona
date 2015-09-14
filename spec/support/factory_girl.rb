require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "username#{n}" }
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    agree_to_terms true

    factory :client do
      role "client"
    end

    factory :stylist do
      role "stylist"
    end
  end
end
