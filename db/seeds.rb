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

f1 = User.find(2).friendships.build(friend_id: 3, confirmed: true)
f2 = User.find(3).friendships.build(friend_id: 10, confirmed: true)
f3 = User.find(4).friendships.build(friend_id: 4, confirmed: false)

[f1, f2, f3].each do |f|
  f.save
end

notification = Notification.create(user_id: f3.friend_id,
                                   notifiable_type: 'Friendship'
                                   notifiable_id: f3.id)
user_count = User.all.length

200.times do
  user_id = rand(1..user_count)
  post_body = Faker::Lorem.paragraph
  Post.create(user_id: user_id, body: post_body)
end

post_count = Post.all.length
500.times do
  user_id = rand(1..user_count)
  post_id = rand(1..post_count)
  comment_body = Faker::Lorem.paragraph
  Comment.create(user_id: user_id, post_id: post_id, body: comment_body)
end

comment_count = Comment.all.length
1000.times do
  comment = Comment.find(rand(1..comment_count))
  user_id = comment.user_id
  post_id = comment.post_id
  reply_body = Faker::Lorem.paragraph
  reply = comment.replies.build(user_id: user_id, post_id: post_id, 
                                body: reply_body)
  reply.save
end
