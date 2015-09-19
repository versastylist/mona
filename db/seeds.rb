# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(
  username: "client",
  email: "client@email.com",
  password: "password",
  password_confirmation: "password",
  role: "client",
  agree_to_terms: true
)

User.create!(
  username: "stylist",
  email: "stylist@email.com",
  password: "password",
  password_confirmation: "password",
  role: "stylist",
  agree_to_terms: true
)

100.times do |n|
  User.create(
    username: Faker::Internet.user_name.gsub(' ', ''),
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password",
    role: "stylist",
    agree_to_terms: true
  )
end

User.reindex
