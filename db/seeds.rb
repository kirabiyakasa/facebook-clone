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

#post_count = Post.all.length
#1000.times do
#  user_id = rand(1..user_count)
#  post_body = FAKER::Lorem.paragraph
#  type = "Post"
#  commentable_id = rand(1..post_count)
#  Post.create()
#end

#new_post_count = Post.all.length
#1000.times do
#  user_id = rand(1..user_count)
#  post_body = FAKER::Lorem.paragraph
#  type = "Post"
#  commentable_id = rand((post_count + 1)..new_post_count)
#  sibling_posts = Post.find(commentable_id).comments
#  sibling_post_count = Post.find(commentable_id).comments.length
#  sibling_post = nil
#  unless rand(5) == < 2
#    if sibling_posts.any?
#      sibling_post = sibling_posts[rand(0..sibling_post_count)]
#      post_body = "@#{sibling_post.user.name} #{post_body}"
#    end
#  end
#  Post.create(user_id: user_id, body: post_body,
#              commentable_type: type, commentable_id: commentable_id)
#end
