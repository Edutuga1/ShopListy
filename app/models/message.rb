class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :content, presence: true

  scope :unread, -> { where(read: false) }

  def belongs_to_user?(user)
    sender == user || receiver == user
  end
end
