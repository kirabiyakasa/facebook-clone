class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true, dependent: :destroy
end
