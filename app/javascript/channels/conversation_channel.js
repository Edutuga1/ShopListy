import consumer from "./consumer";

const conversationId = document.getElementById('conversation-id').dataset.conversationId;

consumer.subscriptions.create({ channel: "ConversationChannel", conversation_id: conversationId }, {
  received(data) {
    const messageContainer = document.getElementById('messages');

    // Append the new message to the container
    const messageElement = document.createElement('div');
    messageElement.classList.add('message');
    messageElement.innerHTML = `
      <strong>${data.sender}:</strong> ${data.content}
      <span class="timestamp">${data.created_at}</span>
    `;
    messageContainer.appendChild(messageElement);
  }
});
