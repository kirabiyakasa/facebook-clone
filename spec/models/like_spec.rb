require 'rails_helper'

RSpec.describe Like, type: :model do

  before(:each) do
    user1 = User.new(name: 'name1', email: 'email1@example.com', password: "abc123")
    user2 = User.new(name: 'name2', email: 'email2@example.com', password: "abc123")
    user1.save
    user2.save
    post = user1.posts.build(body: 'This is a body.')
    post.save
    
    5.times do
      user1.comments.build(body: 'Example body.', post_id: post.id).save
    end

    comments = Comment.all
    5.times do |i|
      i % 2 == 0 ? liked = true : liked = false
      like = Like.new(user_id: user2.id, liked: liked,
                      likable_type: 'Comment', likable_id: comments[i].id)
      like.save
    end
  end

  context 'validations' do
    it 'ensures user cannot like content more than once' do
      like = Like.first
      like = Like.new(user_id: like.user_id, liked: like.liked,
                      likable_type: like.likable_type,
                      likable_id: like.likable_id)
      like = like.save
      expect(like).to eql(false)
    end

    it 'ensures liked is either true or false' do
      like = Like.new(user_id: user_id, likable_type: 'Post',
                                         likable_id: Post.first.id)
      like = like.save
      expect(like).to eql(false)
    end

    it 'saves successfully' do
      like = Like.new(user_id: user_id, liked: true, 
                       likable_type: 'Post', likable_id: Post.first.id)
      like = like.save
      expect(like).to eql(true)
    end
  end

  context 'scope tests' do

    it 'gets likes' do
      user2 = Like.first.user
      likes = Like.liked

      expect(likes.count).to eql(3)
    end

    it 'gets dislikes' do
      user2 = Like.first.user
      dislikes = Like.disliked

      expect(dislikes.count).to eql(2)
    end
  end

end
