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
    friend = User.find(params[:friend_id]) # Fetch friend by friend_id param
    @conversation = Conversation.between(current_user, friend).first_or_create(sender: current_user, receiver: friend)

    if @conversation.persisted?
      redirect_to user_conversation_path(current_user, @conversation), notice: 'Conversation started successfully.'
    else
      render :new, alert: 'Unable to start conversation.'
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

  # ConversationsController#new
  def new
    if params[:friend_id]
      friend = User.find(params[:friend_id])

      # Find or create the conversation with the specified friend
      @conversation = Conversation.between(current_user, friend).first
      unless @conversation
        @conversation = Conversation.create(sender: current_user, receiver: friend)
      end

      # Redirect to the conversation's show page
      redirect_to user_conversation_path(current_user, @conversation)
    else
      # Load friends without conversations if needed for a form display
      @friends_without_conversations = current_user.friends - current_user.conversations.map { |c| c.other_user(current_user) }
    end
  end

  def destroy
    if @conversation.sender == current_user || @conversation.receiver == current_user
      @conversation.destroy
      redirect_to user_conversations_path(current_user), notice: 'Conversation deleted successfully.'
    else
      redirect_to user_conversations_path(current_user), alert: 'You can only delete your own conversations.'
    end
  end
  
  private

  def set_conversation
    @conversation = Conversation.find_by(id: params[:id])
    redirect_to root_path, alert: 'Conversation not found' unless @conversation
  end

  def set_user
    @user = User.find(params[:id]) if params[:id].present?
  end

  def conversation_params
    params.require(:conversation).permit(:receiver_id) # Ensure you permit the receiver_id
  end
end
