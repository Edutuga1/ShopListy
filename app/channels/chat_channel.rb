class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:chat_id]}" # Stream from a specific chat room
  end

  def unsubscribed
    # Cleanup when unsubscribed
  end
end
