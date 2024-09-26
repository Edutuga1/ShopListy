class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:index, :create, :show]

  def index
    @messages = @conversation.messages.order(:created_at)
    @message = @conversation.messages.build
  end

  def new
    @message = Message.new
    @conversation = Conversation.find(params[:conversation_id]) if params[:conversation_id]
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.sender = current_user
    @message.receiver = @conversation.other_user(current_user)

    if @message.save
      respond_to do |format|
        format.turbo_stream   # This will look for a create.turbo_stream.erb view
        format.html { redirect_to conversation_path(@conversation), notice: 'Message was successfully sent.' }
      end
    else
      respond_to do |format|
        format.turbo_stream   # In case of error, still respond with Turbo Stream
        format.html { render :show }
      end
    end
  end

  def show
    @conversation = Conversation.find_by(id: params[:id])
    @user = User.find_by(id: params[:user_id]) # Ensure user_id is passed

    # Add debugging information
    Rails.logger.debug "Current User: #{@user.inspect}, Conversation: #{@conversation.inspect}"

    if @user.nil? || @conversation.nil?
      redirect_to root_path, alert: 'User or conversation not found.'
    else
      @messages = @conversation.messages.order(:created_at)
      @message = Message.new  # Initialize a new message
    end
  end

  def unread_messages_count
    count = Message.where(receiver: current_user, read: false).count
    render json: { count: count }
  end

  private

def set_conversation
  @conversation = Conversation.find_by(id: params[:conversation_id])
  @user = User.find_by(id: params[:user_id])  # Ensure user_id is passed

  Rails.logger.debug "Set Conversation: #{@conversation.inspect}, User: #{@user.inspect}"

  unless @conversation && @user
    redirect_to root_path, alert: 'User or conversation not found.'
  end

  # Check if the user is part of the conversation
  unless @conversation.participants.include?(@user)
    redirect_to root_path, alert: 'User not authorized to view this conversation.'
  end
end

  def message_params
    params.require(:message).permit(:content).merge(conversation_id: @conversation.id, sender_id: current_user.id)
  end
end
