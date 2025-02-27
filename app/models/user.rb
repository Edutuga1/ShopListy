class User < ApplicationRecord
  after_initialize :set_default_notifications, if: :new_record?
  attr_accessor :change_password
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  # Associations
  has_many :groceries, dependent: :destroy
  has_many :own_lists, class_name: 'List', foreign_key: 'user_id', dependent: :destroy # Explicit name for user's own lists
  has_one :cart, dependent: :destroy
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id', dependent: :destroy
  has_many :conversations, through: :sent_messages
  has_one_attached :user_photo
  has_many :friendships, dependent: :destroy
  has_many :friends, -> { where(friendships: { status: 'accepted' }) }, through: :friendships, source: :friend
  has_many :recipes
  has_one :favorite_recipe, class_name: 'Recipe'
  has_many :saved_lists
  has_many :shared_lists, through: :saved_lists, source: :list
  has_many :lists



  # Friendships where the user is the recipient
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  has_many :inverse_friends, -> { where(friendships: { status: 'accepted' }) }, through: :inverse_friendships, source: :user

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validate :acceptable_image
  validates :password, presence: true, if: -> { new_record? || password.present? }
  validates :password_confirmation, presence: true, if: -> { password.present? }


  # Checks if the current user is friends with another user
  def friend?(other_user)
    return false if other_user.nil? # Prevent calling id on nil
    friendships.exists?(friend_id: other_user.id, status: 'accepted') ||
    inverse_friendships.exists?(user_id: other_user.id, status: 'accepted')
  end

  def friends
    Friendship.where(user_id: id, status: 'accepted').map(&:friend) +
    Friendship.where(friend_id: id, status: 'accepted').map(&:user)
  end

  # Method to send a friend request
  def send_friend_request(friend)
    friendships.create(friend: friend, status: 'pending')
    Rails.logger.debug "Friend request created from User ID: #{id} to User ID: #{friend.id}"
  end

  # Method to accept a friend request
  def accept_friend_request(friendship)
    friendship.update(status: 'accepted')
    Rails.logger.debug "Friend request accepted for User ID: #{id}, Friendship ID: #{friendship.id}"
  end

  # Method to reject a friend request
  def reject_friend_request(friendship)
    friendship.update(status: 'rejected')
    Rails.logger.debug "Friend request rejected for User ID: #{id}, Friendship ID: #{friendship.id}"
  end

  # Returns pending friend requests received by the user
  def pending_friend_requests
    Friendship.where(friend_id: self.id, status: 'pending')
  end

  # Checks if a friend request is pending or has been sent to/from another user
  def friend_request_exists?(other_user)
    friendships.exists?(friend_id: other_user.id, status: 'pending') ||
    inverse_friendships.exists?(user_id: other_user.id, status: 'pending')
  end

  # Custom method to count unread messages
  def unread_messages_count
    received_messages.where(read: false).count
  end

  # Returns user photo if attached, otherwise a default path
  def user_photo_or_default
    user_photo.attached? ? user_photo : "default-avatar.png"
  end

  def update_without_password(params)
    params.delete(:password) if params[:password].blank?
    params.delete(:password_confirmation) if params[:password_confirmation].blank?

    update(params)
  end

  def admin?
    admin
  end

  def user_params
    params.require(:user).permit(:name, :email, :current_password, :password, :password_confirmation, :notifications_enabled)
  end

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    unless user
      user = User.create(
        email: auth.info.email,
        password: Devise.friendly_token[0, 20],
        name: auth.info.name,        # Store user's name
        image: auth.info.image       # Optionally, store user's profile picture URL
      )
    end
    user
  end


  private

  # Validates attached image size and type
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

  def self.search(email)
    # Using `where` to perform a case-insensitive search
    where("email ILIKE ?", "%#{email}%")
  end

  def set_default_notifications
    self.notifications_enabled = true if notifications_enabled.nil?
  end
end
