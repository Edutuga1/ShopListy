import consumer from "./consumer";

document.addEventListener("turbo:load", () => {
  const conversationId = document.getElementById("conversation-header")?.dataset.conversationId;

  if (conversationId) {
    // Subscribe to the conversation channel
    consumer.subscriptions.create(
      { channel: "ConversationChannel", conversation_id: conversationId },
      {
        received(data) {
          // Append the new message to the messages container
          const messagesContainer = document.getElementById("messages-container");
          const newMessage = document.createElement("div");
          newMessage.classList.add("message");
          newMessage.innerHTML = `
            <div class="message-header">
              <span class="sender">${data.sender}</span>
              <span class="time">${data.created_at}</span>
            </div>
            <p class="content">${data.content}</p>
          `;
          messagesContainer.appendChild(newMessage);

          // Optionally scroll to the bottom of the chat
          messagesContainer.scrollTop = messagesContainer.scrollHeight;
        },
      }
    );
  }
});
