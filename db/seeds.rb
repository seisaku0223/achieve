# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
30.times do |n|
  email = Faker::Internet.email
  password = "password"
  name = Faker::Name.name
  user = User.create!(email: email,
               password: password,
               password_confirmation: password,
               name: name
              )
  content = Takarabako.open
  user.blogs.create(
              title:"宝箱から発見！！",
              content: content,
              )
end
