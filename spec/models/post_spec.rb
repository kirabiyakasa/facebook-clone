require 'rails_helper'

RSpec.describe Post, type: :model do

  before(:each) do
    User.new(name: 'name', email: 'email@example.com', password: "abc123").save
  end

  context 'validation tests' do
    it 'ensures presence of user_id' do
      post = Post.new(body: 'Example body.').save
      expect(post).to eql(false)
    end

    it 'ensures body presence' do
      post = Post.new(user_id: user_id).save
      expect(post).to eql(false)
    end

    it 'ensures body is greater than 0 characters' do
      post = Post.new(user_id: user_id, body: '').save
      expect(post).to eql(false)
    end

    it 'ensures body is no more than 500 characters' do
      post = Post.new(user_id: user_id)
      post.body = Faker::Lorem.characters(number: 501)
      post = post.save

      expect(post).to eql(false)
    end

    it 'should save successfully' do
      post = Post.new(user_id: user_id, body: 'Example body.').save
      expect(post).to eql(true)
    end
  end

end
