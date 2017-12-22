# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
20.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  uid = SecureRandom.uuid
  user = User.create!(email: email,
               password: password,
               password_confirmation: password,
               name: name,
               uid: uid
              )
end
