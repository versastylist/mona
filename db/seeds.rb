require 'csv'

User.create(
  username: "admin",
  email: "admin@email.com",
  password: "password",
  password_confirmation: "password",
  role: "admin",
  agree_to_terms: true
)

User.create(
  username: "client",
  email: "client@email.com",
  password: "password",
  password_confirmation: "password",
  role: "client",
  agree_to_terms: true
)

User.create(
  username: "stylist",
  email: "stylist@email.com",
  password: "password",
  password_confirmation: "password",
  role: "stylist",
  agree_to_terms: true
)

## Create Registered Stylist ##

reg_stylist = User.create(
  username: "registeredstylist",
  email: "rsty@email.com",
  password: "password",
  password_confirmation: "password",
  role: "stylist",
  agree_to_terms: true
)

r = reg_stylist.build_registration(
  first_name: "Frank",
  last_name: "Sinatra",
  phone_number: "6178936734",
  dob: "09/09/09",
  gender: "Male",
)
r.save!

p = reg_stylist.build_payment_info(
  stripe_customer_token: '234lkj234',
)
p.save!

## Create Service Menu Categories ##
categories = ["Hair Cut","Weave", "Blowout And Sets", "Natural", "Barber", "Nails", "Makeup", "Specialties"]
categories.each do |cat|
  ServiceMenu.find_or_create_by(name: cat)
end

30.times do|n|
  stylist = User.create(
    username: "stylist#{n}",
    email: "stylist#{n}@email.com",
    password: "password",
    password_confirmation: "password",
    role: "stylist",
    agree_to_terms: true
  )

  r = stylist.build_registration(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.cell_phone,
    dob: 3.days.ago.to_s,
    gender: ["Male", "Female"].sample
  )
  r.save!

  p = stylist.build_payment_info(
    stripe_customer_token: '234lkj234',
  )
  p.save!
end

categories.each do |cat|
  menu = ServiceMenu.find_by(name: cat)
  service = reg_stylist.services.create(service_menu_id: menu.id)
  filename = cat.downcase.split(' ').join('_') + '.csv'

  CSV.foreach(Rails.root.join('db', 'seed_data', filename), headers: true, header_converters: :symbol, encoding:'iso-8859-1:utf-8') do |row|
    sp = row.to_hash

    service.service_products.create(
      name: sp[:name],
      hours: sp[:hours].to_i,
      minutes: sp[:minutes].to_i,
      price: sp[:price],
      details: sp[:details],
      preparation_instructions: sp[:prep_instructions]
    )
  end
end
