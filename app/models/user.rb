class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :groceries, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id', dependent: :destroy
  has_one_attached :user_photo

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validate :acceptable_image

  # Custom methods
  def has_unread_messages?
    received_messages.unread.exists?
  end

  def user_photo_or_default
    if user_photo.attached?
      user_photo
    else
      # Replace with your default image URL or path
      "default-avatar.png"
    end
  end

  private

  def acceptable_image
    return unless user_photo.attached?

    if user_photo.byte_size > 1.megabyte
      errors.add(:user_photo, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(user_photo.content_type)
      errors.add(:user_photo, "must be a JPEG or PNG")
    end
  end
end
