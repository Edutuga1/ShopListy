import consumer from "./consumer";

document.addEventListener('turbolinks:load', () => {
  if (document.body.contains(document.querySelector('.messages-page'))) {
    const notificationsChannel = consumer.subscriptions.create("NotificationChannel", {
      received(data) {
        // Update unread message count
        if (data.count !== undefined) {
          document.getElementById('unread-message-count').textContent = data.count;

          // Show a notification popup if there's an unread message
          if (data.count > 0) {
            alert(`You have ${data.count} new message(s)! View Messages`);
          }
        }
      }
    });
  }
});
