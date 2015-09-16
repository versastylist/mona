require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "username#{n}" }
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    agree_to_terms true
    role 'user'

    factory :client do
      role "client"
    end

    factory :stylist do
      role "stylist"
    end
  end

  factory :registration do
    first_name 'johnny'
    last_name 'jones'
    phone_number '555-555-5555'
    dob '09/09/09'
    gender 'Male'
    timezone 'East'
    user
  end
end
