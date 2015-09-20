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

    factory :registered_client do
      role "client"
      registration
      payment_info
    end

    factory :registered_stylist do
      role "stylist"
      registration
      payment_info
    end
  end

  factory :registration do
    first_name 'johnny'
    last_name 'jones'
    phone_number '555-555-5555'
    dob '09/09/09'
    gender 'Male'
    user
  end

  factory :payment_info do
    user
    stripe_customer_token "sldkfj23kjlsdf"
    stripe_card_token "slfkjaa234lk234s"
  end

  factory :service_menu do
    name 'Barber'
  end
end
