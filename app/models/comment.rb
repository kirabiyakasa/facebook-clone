class Comment < ApplicationRecord
  REPLIES_PER_PAGE = 15

  belongs_to :user
  belongs_to :post
  belongs_to :comment, class_name: 'Comment', foreign_key: 'comment_id', 
             optional: true

  has_many :replies, -> { replied }, class_name: 'Comment',
           foreign_key: 'comment_id', dependent: :destroy
  has_many :recent_replies, -> { recent_replied }, class_name: 'Comment',
           foreign_key: 'comment_id', dependent: :destroy

  scope :commented, -> { where comment_id: nil }
  scope :replied, -> { where.not(comment_id: nil) }
  scope :recent_replied, -> { where.not(comment_id: nil)
                                   .order('created_at ASC')
                                   .limit(REPLIES_PER_PAGE) }

  has_many :likes, -> { liked }, as: :likable, class_name: 'Like',
           dependent: :destroy
  has_many :dislikes, -> { disliked }, as: :likable, class_name: 'Like',
           dependent: :destroy

  #has_one :image
  #has_one :video

  def get_next_replies(comment, offset, limit)
    return comment.replies.order('created_at ASC')
                          .includes(:user, :likes, :dislikes)
                          .offset(offset)
                          .limit(limit)
  end

  def replies_per_page
    return REPLIES_PER_PAGE
  end

end
