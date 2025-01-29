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
      # Broadcast the message via ActionCable for real-time updates
      ActionCable.server.broadcast "conversation_#{@conversation.id}_channel", {
        content: @message.content,
        sender: @message.sender.name,
        receiver: @message.receiver.name,
        message_id: @message.id,
        created_at: @message.created_at
      }

      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.append("messages", partial: "messages/message", locals: { message: @message }) }
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
    @conversation = Conversation.find(params[:id])

    # Mark all unread messages in this conversation as read for the current user
    @conversation.messages.where(receiver_id: current_user.id, read: false).update_all(read: true)

    respond_to do |format|
      format.html
      format.json { render json: @conversation }
    end
  end
  
  def unread_messages_count
    count = Message.where(receiver_id: current_user.id, read: false).count
    render json: { unread_messages: count }, status: :ok
  end

  def mark_messages_as_read
    # Update messages in the conversation
    Message.where(receiver_id: current_user.id, conversation_id: params[:conversation_id], read: false).update_all(read: true)

    # Return the updated count of unread messages
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
