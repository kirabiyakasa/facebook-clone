class Post < ApplicationRecord
  belongs_to :user
  has_one :notification, as: :notifiable, dependent: :destroy

  has_many :comments, -> { commented }, dependent: :destroy
  has_many :replies, -> { replied }, class_name: 'Comment'

  has_many :likes, -> { liked }, as: :likable, class_name: 'Like'
  has_many :dislikes, -> { disliked }, as: :likable, class_name: 'Like'

  validates :body, length: { minimum: 1, maximum: 500 }
end
