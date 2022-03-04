class Like < ApplicationRecord
  belongs_to :user

  belongs_to :likable, polymorphic: true

  scope :liked, -> { where liked: true }
  scope :disliked, -> { where liked: false }

  validates :likable_id, uniqueness: {
    :scope => [:likable_id, :likable_type]
  }
end
