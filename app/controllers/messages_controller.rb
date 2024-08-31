class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_users, only: [:new, :create]

  def index
    @received_messages = current_user.received_messages
    @sent_messages = current_user.sent_messages
  end

  def new
    @message = Message.new
  end

  def create
    @message = current_user.sent_messages.build(message_params)
    if @message.save
      # Broadcast the notification
      MessageNotificationChannel.broadcast_to(
        @message.receiver,
        { message: "You have a new message from #{current_user.name}" }
      )
      redirect_to user_messages_path(current_user), notice: 'Message sent successfully.'
    else
      render :new
    end
  end

  def show
    @message = Message.find(params[:id])
    @message.update(read: true) if @message.receiver == current_user
  end

  def unread_messages_count
    count = current_user.received_messages.where(read: false).count
    render json: { unread_messages: count }
  end

  private

  def set_users
    @users = User.where.not(id: current_user.id)
  end

  def message_params
    params.require(:message).permit(:receiver_id, :content, :subject, :body)
  end
end
