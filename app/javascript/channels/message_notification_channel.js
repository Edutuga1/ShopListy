import consumer from "./consumer";

document.addEventListener("turbo:load", () => {
  if (!document.querySelector(".messages-page")) return;

  consumer.subscriptions.create("NotificationChannel", {
    received(data) {
      if (data.count === undefined) return;

      const counter = document.getElementById("unread-message-count");
      if (counter) counter.textContent = data.count;

      if (data.count > 0) {
        alert(`You have ${data.count} new message(s)! View Messages`);
      }
    },
  });
});
