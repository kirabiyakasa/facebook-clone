class User < ApplicationRecord
  include Gravtastic
  gravtastic
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships
  has_many :inverse_friendships, :class_name => "Friendship", 
           :foreign_key => "friend_id"
  has_many :posts
  has_many :likes
  has_many :notifications

  def friends
    friend_ids = friendships.map{
      |friendship| friendship.friend_id if friendship.confirmed
    }
    friend_ids += inverse_friendships.map{
      |friendship| friendship.user_id if friendship.confirmed
    }
    User.where(id: friend_ids)
  end

  # Users to whom unconfirmed friend requests have been sent
  def pending_friends
    friend_ids = friendships.map{
      |friendship| friendship.friend_id if !friendship.confirmed
    }.compact
    User.where(id: friend_ids)
  end

  # Users from whom friend requests have been sent
  def friend_requests
    user_ids = inverse_friendships.map{
      |friendship| friendship.user_id if !friendship.confirmed
    }.compact
    User.where(id: user_ids)
  end

  # method for mutual friends

  def confirm_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end

  def user_is_self?(user_id)
    self.id == user_id
  end

  def friendship_already_exists?(user_id)
    if friendships.find_by(friend_id: user_id) ||
       inverse_friendships.find_by(user_id: user_id)
      return true
    end
  end

end
