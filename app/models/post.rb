class Post < ApplicationRecord
  belongs_to :user #dependent destroy?
  has_many :notifications, as: :notifiable 

  has_many :likes, -> { liked }, class_name: 'Like'
  has_many :dislikes, -> { disliked }, class_name: 'Like'
end
