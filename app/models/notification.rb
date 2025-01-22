class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
  belongs_to :list

  validates :message, presence: true
end
