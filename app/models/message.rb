class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'

  validates :content, presence: true
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :conversation, presence: true

  scope :unread, -> { where(read: false) }

  def belongs_to_user?(user)
    sender == user || receiver == user
  end

  def mark_as_read!
    update(read: true)
  end

  def user
    sender  # or you might want to use `receiver` based on context
  end
end
