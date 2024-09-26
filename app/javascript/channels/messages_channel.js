// app/javascript/channels/messages_channel.js
import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('conversation_id');
  const conversationId = element.getAttribute('data-conversation-id');

  if (conversationId) {
    consumer.subscriptions.create({ channel: "MessagesChannel", conversation_id: conversationId }, {
      received(data) {
        document.getElementById('messages-list').insertAdjacentHTML('beforeend', data);
      }
    });
  }
});
