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
    friendships.map{
      |friendship| friendship.friend if !friendship.confirmed
    }.compact
  end

  # Users from whom friend requests have been sent
  def friend_requests
    inverse_friendships.map{
      |friendship| friendship.user if !friendship.confirmed
    }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end

end
