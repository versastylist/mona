require 'csv'

# Create admin user
User.create(
  username: "admin",
  email: "admin@email.com",
  password: "password",
  password_confirmation: "password",
  role: "admin",
  agree_to_terms: true
)

# Use admin to build registration surveys
SurveyBuilder.build_client_registration
SurveyBuilder.build_stylist_registration

# Create GlobalSettings
gs = GlobalSetting.instance
gs.update(
  appointment_buffer: 30,
)

# Build unregistered client/stylists for testing
User.create(
  username: "client",
  email: "client@email.com",
  password: "password",
  password_confirmation: "password",
  role: "client",
  agree_to_terms: true
)

User.create(
  username: "applesauce",
  email: "client1@email.com",
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

# Create Registered Stylist
reg_stylist = User.create(
  username: "registeredstylist",
  email: "rsty@email.com",
  password: "password",
  password_confirmation: "password",
  role: "stylist",
  agree_to_terms: true,
)
settings = reg_stylist.settings
settings.verified = true
settings.premium_membership = true
settings.save!

r = reg_stylist.build_registration(
  first_name: "Frank",
  last_name: "Sinatra",
  phone_number: "617 893 6734",
  dob: "1992/06/19",
  gender: "Male",
)
r.save!

p = reg_stylist.build_payment_info(
  stripe_customer_token: '234lkj234',
)
p.save!

Address.create(
  primary: true,
  address: '544 walnut street',
  zip_code: '02460',
  state: 'Massachusetts',
  city: 'Newton',
  user_id: reg_stylist.id
)

# Complete stylist registraiton survey without answers
survey = Survey.find_by(title: 'Stylist Registration')
reg_stylist.completions.create(survey_id: survey.id)

## Create Service Menu Categories ##
categories = ["Hair Cut","Weave", "Blowout And Sets", "Natural", "Barber", "Nails", "Makeup", "Specialties"]
categories.each do |cat|
  ServiceMenu.find_or_create_by(name: cat)
end

5.times do|n|
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
    phone_number: '718 832 9823',
    dob: '1992-06-29',
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
