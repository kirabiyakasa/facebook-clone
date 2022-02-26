class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :replies, -> { replied }, class_name: 'Comment',
           foreign_key: 'comment_id', dependent: :destroy
  belongs_to :comment, class_name: 'Comment', foreign_key: 'comment_id', 
             optional: true
  scope :commented, -> { where comment_id: nil }
  scope :replied, -> { where.not(comment_id: nil) }

  has_many :likes, -> { liked }, as: :likable, class_name: 'Like',
           dependent: :destroy
  has_many :dislikes, -> { disliked }, as: :likable, class_name: 'Like',
           dependent: :destroy

  #has_one :image
  #has_one :video
end
