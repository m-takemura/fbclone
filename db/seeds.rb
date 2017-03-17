# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Faker::Config.locale=:ja

10.times do |n|
  email = Faker::Internet.email
  name = Faker::Name.name
  uid = Faker::Lorem.characters(32)
  password = "password"
  User.create!(email: email,
               password: password,
               password_confirmation: password,
               name: name,
               uid: uid,
               )
end

users=User.all
users.each do |f|
  user_id=f.id
  content=Faker::Lorem.sentence
  Topic.create!(user_id: user_id,
               content: content,
               )
end

topics=Topic.all
topics.each do |f|
  topic_id=f.id
  user_id=User.where('id>=?',rand(User.first.id..User.last.id)).first.id
  content=Faker::Lorem.sentence
  Comment.create!(
               topic_id: topic_id,
               user_id: user_id,
               content: content,
               )
end
