class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validate :sender_is_not_receiver

  scope :between, -> (user1, user2) do
    where(sender_id: user1.id, receiver_id: user2.id)
      .or(where(sender_id: user2.id, receiver_id: user1.id))
  end

  def self.get(sender_id, receiver_id)
    conversation = between(User.find(sender_id), User.find(receiver_id)).first
    conversation ||= create(sender_id: sender_id, receiver_id: receiver_id)
    conversation
  end

  def other_user(current_user)
    (self.sender == current_user) ? self.receiver : self.sender
  end

  def participants
    [sender, receiver]
  end
  
  private

  def sender_is_not_receiver
    errors.add(:receiver_id, 'cannot be the same as sender') if sender_id == receiver_id
  end
end
