class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:index, :create, :show]

  def index
    @messages = @conversation.messages.order(:created_at)
    @message = @conversation.messages.build
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.sender = current_user
    @message.receiver = @conversation.other_user(current_user)

    if @message.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to conversation_path(@conversation), notice: 'Message sent.' }
      end
    else
      respond_to do |format|
        format.turbo_stream
        format.html { render :show }
      end
    end
  end

  def show
    @messages = @conversation.messages.order(:created_at)
    @message = Message.new # Initialize a new message
  end

  def mark_as_read
    message = Message.find(params[:message_id])
    message.mark_as_read!
    unread_count = Message.where(receiver_id: current_user.id, read: false).count
    render json: { unread_messages: unread_count }, status: :ok
  end

  def unread_messages_count
    count = Message.where(receiver_id: current_user.id, read: false).count
    render json: { unread_messages: count }, status: :ok
  end

  private

  def set_conversation
    @conversation = Conversation.find_by(id: params[:conversation_id])
    unless @conversation && @conversation.participants.include?(current_user)
      redirect_to root_path, alert: 'Unauthorized or conversation not found.'
    end
  end

  def message_params
    params.require(:message).permit(:content).merge(conversation_id: @conversation.id)
  end
end
