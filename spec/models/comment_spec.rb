require 'rails_helper'

RSpec.describe Comment, type: :model do

  before(:each) do
    user = User.new(name: 'name', email: 'email@example.com',
                    password: "abc123")
    user.save
    user.posts.build(body: 'This is a body.').save
  end

  context 'validation tests' do

    context 'comment validations' do
      it 'validates presence of body' do
        comment = Comment.new(user_id: user_id, post_id: post_id).save
        expect(comment).to eql(false)
      end

      it 'ensures body is more than 0 characters' do
        comment = Comment.new(body: '', user_id: user_id, post_id: post_id).save

        expect(comment).to eql(false)
      end

      it 'ensures body no more than 500' do
        comment = Comment.new(user_id: user_id, post_id: post_id)
        comment.body = Faker::Lorem.characters(number: 501)
        comment = comment.save

        expect(comment).to eql(false)
      end

      it 'ensures user_id presence' do
        comment = Comment.new(body: 'Example body.', post_id: post_id).save

        expect(comment).to eql(false)
      end

      it 'ensures post_id presence' do
        comment = Comment.new(body: 'Example body.', user_id: user_id).save

        expect(comment).to eql(false)
      end

      it 'saves successfully' do
        comment = Comment.new(body: 'Example body.', user_id: user_id,
                              post_id: post_id).save

        expect(comment).to eql(true)
      end
    end
  end

  context 'scope tests' do
    let (:params) { {} }
    before(:each) do
      user = User.last
      10.times do
        Comment.new(user_id: user.id, post_id: Post.first.id,
                    body: 'Example body.').save
      end
      generate_replies(12, 2, user.id)
      generate_replies(17, 5, user.id)
    end

    it 'gets replies only' do
      replies = Post.first.comments[2].replies
      expect(replies.count).to eql(12)
    end

    it 'gets recent replies' do
      recent_replies = Post.first.comments[5].recent_replies.count
      expect(recent_replies).to eql(Comment.new.replies_per_page)
    end
  end

  def generate_replies(count, comment_num, user_id)
    comment_id = Post.first.comments[comment_num].id
    count.times do
      reply = Comment.new(user_id: user_id, post_id: Post.first.id,
                          body: 'Example body.', comment_id: comment_id)
      reply.save
    end
  end

end
