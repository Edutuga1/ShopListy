class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_and_belongs_to_many :participants, class_name: 'User'

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
    sender == current_user ? receiver : sender
  end

  def participants
    [sender, receiver]
  end

  def mark_messages_as_read(user)
    # Assuming you have a Message model with a read attribute and a conversation_id foreign key
    messages.where(receiver_id: user.id).update_all(read: true)
  end

   # Scope to find conversations between two specific users
   scope :between, ->(user1, user2) {
  where(sender: user1, receiver: user2).or(where(sender: user2, receiver: user1))
}

  private

  def sender_is_not_receiver
    errors.add(:receiver_id, 'cannot be the same as sender') if sender_id == receiver_id
  end
end
