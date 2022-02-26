class Like < ApplicationRecord
  belongs_to :user

  belongs_to :likable, polymorphic: true

  scope :liked, -> { where liked: true }
  scope :disliked, -> { where liked: false }
end
