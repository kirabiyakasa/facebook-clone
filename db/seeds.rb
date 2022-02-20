# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |i|
  User.create(name: "user#{i + 1}", email: "user#{i + 1}@example.com", 
              password: "abc123")
end

friendship1 = User.find(2).friendships.build(friend_id: 3, confirmed: true)
friendship1.save

100.times do
  user_id = rand(1..(User.all.length))
  post_body = Faker::Lorem.paragraph
  Post.create(user_id: user_id, body: post_body)
end
