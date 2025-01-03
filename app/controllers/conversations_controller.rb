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
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)
    @message.sender = current_user

    if @message.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to user_conversation_path(current_user, @conversation), notice: 'Message sent.' }
      end
    else
      flash[:alert] = "Unable to send message."
      redirect_to user_conversation_path(current_user, @conversation)
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
    @conversation = Conversation.find(params[:id])

    if @conversation.nil? || (@conversation.sender != current_user && @conversation.receiver != current_user)
      redirect_to user_conversations_path(current_user), alert: 'Unauthorized action or conversation not found.'
    else
      @conversation.destroy
      respond_to do |format|
        format.html { redirect_to user_conversations_path(current_user), notice: 'Conversation deleted successfully.' }
        format.turbo_stream # This allows Turbo to handle the removal without a full page refresh
      end
    end
  end


  private

  def set_conversation
    @conversation = Conversation.find_by(id: params[:id])
    unless @conversation
      redirect_to user_conversations_path(current_user), alert: 'Conversation not found'
    end
  end

  def set_user
    @user = User.find(params[:id]) if params[:id].present?
  end

  def conversation_params
    params.require(:conversation).permit(:receiver_id) # Ensure you permit the receiver_id
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
