class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show]

  # Show a list of conversations
  def index
    @conversations = Conversation.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
                                  .includes(:messages)

    @friends = current_user.friends

    # Identify friends who do not have an existing conversation
    @friends_without_conversations = @friends.reject do |friend|
      @conversations.any? { |c| c.other_user(current_user) == friend }
    end

    @pending_friend_requests = current_user.pending_friend_requests
  end

  # Create a new conversation
  def create
    @conversation = Conversation.new(conversation_params)
    @conversation.sender_id = current_user.id

    if @conversation.save
      redirect_to user_conversation_path(current_user, @conversation), notice: 'Conversation started successfully.'
    else
      render :new
    end
  end

  def mark_as_read
    # Find the conversation by ID
    @conversation = Conversation.find(params[:id])

    # Mark messages as read (implement your logic here)
    # For example, assuming you have a method that marks messages as read
    @conversation.mark_messages_as_read(current_user)

    # Return the unread message count as JSON
    render json: { unread_messages: current_user.unread_messages_count }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Conversation not found' }, status: :not_found
  end


  # Show a specific conversation
  def show
    @messages = @conversation.messages.includes(:sender).order(created_at: :asc)
  end

  def new
    @friend = User.find(params[:friend_id]) # Assuming friend_id is passed in the URL
    @conversation = Conversation.new
  end

  private

  def set_conversation
    @conversation = Conversation.find_by(id: params[:id])
    redirect_to root_path, alert: 'Conversation not found' unless @conversation
  end

  def message_params
    params.require(:message).permit(:receiver_email, :receiver_id, :content)
  end

  def set_user
    @user = User.find(params[:id]) if params[:id].present?
  end

  def conversation_params
    params.require(:conversation).permit(:receiver_id) # Ensure you permit the receiver_id
  end
end
