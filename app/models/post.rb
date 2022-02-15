class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, -> { liked }, class_name: 'Like'
  has_many :dislikes, -> { disliked }, class_name: 'Like'
end
