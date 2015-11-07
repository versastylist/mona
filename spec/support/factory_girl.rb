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

      after :create do |user|
        survey = create(:survey, title: "#{user.role.capitalize} Registration")
        create(:completion, survey: survey, user: user)
      end
    end

    trait :premium_member do
      after :create do |user|
        user.settings.update(premium_membership: true, verified: true)
      end
    end

    trait :disabled do
      after :create do |user|
        user.settings.update(enable_booking: false)
      end
    end

    trait :receive_email do
      after :create do |user|
        user.settings.update(booking_emails: true)
      end
    end

    trait :receive_texts do
      after :create do |user|
        user.settings.update(booking_texts: true)
      end
    end
  end

  factory :registration do
    first_name 'johnny'
    last_name 'jones'
    phone_number '555-555-5555'
    dob '1992/06/19'
    gender 'Male'
    user
  end

  factory :address do
    primary true
    address "1 Congress St"
    zip_code "02345"
    state "Massachusetts"
    city "Boston"
    longitude 30
    latitude 30
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

  factory :completion do
    survey
    user
  end

  factory :confirm_submittable do
  end

  factory :option do
    text 'Hello'
  end

  factory :multiple_choice_submittable do
    transient do
      options_texts { [] }
    end

    options do |attributes|
      attributes.options_texts.map do |text|
        FactoryGirl.build(:option, text: text, question_id: attributes.id)
      end
    end
  end

  factory :question do
    sequence(:title) { |n| "Question #{n}" }
    submittable factory: :confirm_submittable
    survey

    factory :multiple_choice_question do
      submittable factory: :multiple_choice_submittable
    end

    # Will implement open_question when I need it. 10/3
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

  factory :order do
    order_status
  end

  factory :order_status do
    name "In Progress"
  end

  factory :order_item do
    quantity 1
    order
    service_product
  end

  factory :schedule do
    state 'current'
    start_date 1.day.from_now
    end_date 14.days.from_now
    stylist

    factory :current_schedule do
      state 'current'
    end

    factory :future_schedule do
      state 'future'
    end
  end

  factory :week_day do
    day_of_week 1.day.from_now
    start_time DateTime.parse("9:00am")
    end_time DateTime.parse("5:00pm")
    schedule
    active true
  end

  factory :time_interval do
    title "Lunch"
    start_time DateTime.parse("11:00am")
    end_time DateTime.parse("12:00pm")
    week_day
  end

  factory :appointment do
    start_time DateTime.parse("3:00pm")
    end_time DateTime.parse("4:00pm")
    order
    stylist
    client

    trait :with_interval do
      after :create do |appt|
        create(
          :time_interval,
          start_time: appt.start_time,
          end_time: appt.start_time,
          appointment_id: appt.id
        )
      end
    end
  end

  factory :stylist_photo do
    image 'some image'
    stylist
  end
end
