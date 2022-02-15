class Like < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :post, dependent: :destroy

  scope :liked, -> { where liked: true }
  scope :disliked, -> { where liked: false }
end
