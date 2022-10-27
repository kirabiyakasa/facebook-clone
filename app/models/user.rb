class User < ApplicationRecord
  include Gravtastic
  gravtastic
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, :class_name => "Friendship", 
           :foreign_key => "friend_id", dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true

  def friends
    friend_ids = friendships.where(confirmed: true).pluck(:friend_id)
    friend_ids += inverse_friendships.where(confirmed: true).pluck(:user_id)
    User.where(id: friend_ids).compact
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
