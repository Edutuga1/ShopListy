import consumer from "./consumer";

document.addEventListener('turbolinks:load', () => {
  if (document.body.contains(document.querySelector('.messages-page'))) {
    const notificationsChannel = consumer.subscriptions.create("NotificationChannel", {
      received(data) {
        // Show a notification popup
        alert(data.message);
      }
    });
  }
});
