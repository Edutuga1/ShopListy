// app/javascript/channels/messages_channel.js
import consumer from "./consumer"

document.addEventListener("turbo:load", () => {
  const element = document.getElementById("conversation_id");
  if (!element) return;

  const conversationId = element.getAttribute("data-conversation-id");
  if (!conversationId) return;

  consumer.subscriptions.create(
    { channel: "MessagesChannel", conversation_id: conversationId },
    {
      received(data) {
        const list = document.getElementById("messages-list");
        if (list) list.insertAdjacentHTML("beforeend", data);
      },
    }
  );
});
