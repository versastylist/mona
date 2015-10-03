require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "username#{n}" }
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    agree_to_terms true
    role 'user'

    factory :admin, aliases: [:author] do
      role "admin"
      registration
      payment_info
    end

    factory :client do
      role "client"
    end

    factory :stylist do
      role "stylist"
    end

    trait :with_registration do
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

  factory :survey do
    title 'Client Registration'
    author
  end

  factory :confirm_submittable do
  end

  factory :question do
    sequence(:title) { |n| "Question #{n}" }
    submittable factory: :confirm_submittable
    survey

    # Will want to create these types of questions soon
    # factory :multiple_choice_question do
      # submittable factory: :multiple_choice_submittable
    # end

    # factory :open_question do
      # submittable factory: :open_submittable
    # end

    factory :confirm_question do
      submittable factory: :scale_submittable
    end
  end

  factory :service_menu do
    name 'Barber'
  end

  factory :service_product do
    name 'Buzz Cut'
    minute_duration 30
    hours 0
    minutes 30
    price 25
    details "A buzz cut for kids"
    preparation_instructions "Be prepared to have no more hair after the buzz cut"
    displayed true
    service
  end

  factory :service do
    service_menu
    stylist
  end
end
