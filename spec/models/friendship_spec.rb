require 'rails_helper'

RSpec.describe Friendship, type: :model do

  before(:each) do
    User.new(name: 'name1', email: 'email1@example.com', password: "abc123").save
    User.new(name: 'name2', email: 'email2@example.com', password: "abc123").save
  end

  context 'validations' do

    it 'ensures user_id presence' do
      friendship = Friendship.new(friend_id: User.last.id).save
      expect(friendship).to eql(false)
    end

    it 'ensures friend_id presence' do
      friendship = Friendship.new(user_id: User.first.id).save
      expect(friendship).to eql(false)
    end

    it 'ensures confirmed status defauls to false' do
      friendship = Friendship.new(user_id: User.first.id,
                                  friend_id: User.last.id)
      expect(friendship.confirmed).to eql(false)
    end

    it 'saves successfully' do
      friendship = Friendship.new(user_id: User.first.id,
                                  friend_id: User.last.id).save
      expect(friendship).to eql(true)
    end

  end
end
