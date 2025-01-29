class ConversationChannel < ApplicationCable::Channel
  def subscribed
    # Stream from a conversation channel
    stream_from "conversation_#{params[:conversation_id]}_channel"
  end

  def unsubscribed
    # Clean up any resources when unsubscribed
  end
end
