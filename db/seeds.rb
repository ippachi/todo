# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: "hoge", email: "hoge@hoge.hoge", password: "hogehoge")

50.times do |i|
  User.create!(name: Faker::Name.name, email: Faker::Internet.unique.email, password: "password")
end

users = User.all

users.each do |user|
  50.times do |i|
    user.tasks.create!(title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph)
  end
end