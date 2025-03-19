class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, uniqueness: { scope: :friend_id, message: "Friendship already exists" }
  validates :status, inclusion: { in: %w[pending accepted rejected] }

  # Status can be 'pending', 'accepted', or 'rejected'
  enum status: { pending: 'pending', accepted: 'accepted', rejected: 'rejected' }
end
