class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show]

  # Show a list of conversations
  def index
    @conversations = Conversation.where(sender_id: current_user.id).or(Conversation.where(receiver_id: current_user.id))
  end

  # Create a new conversation
  def create
    # Find the receiver by their ID (sent from the form)
    receiver = User.find(params[:receiver_id])

    # Check if a conversation already exists between these two users
    existing_conversation = Conversation.between(current_user, receiver).first

    if existing_conversation
      redirect_to user_conversation_path(current_user, existing_conversation)
    else
      # Create a new conversation
      conversation = Conversation.create(sender: current_user, receiver: receiver)

      if conversation.persisted?
        redirect_to user_conversation_path(current_user, conversation), notice: "Conversation started with #{receiver.name}"
      else
        redirect_to user_conversations_path(current_user), alert: "Failed to start conversation"
      end
    end
  end

  # Show a specific conversation
  def show
    @messages = @conversation.messages.order(:created_at)
  end

  private

  def set_conversation
    @conversation = Conversation.find_by(id: params[:id])
    redirect_to root_path, alert: 'Conversation not found' unless @conversation
  end

  def message_params
    params.require(:message).permit(:receiver_email, :receiver_id, :content)
  end
end
