document.addEventListener('DOMContentLoaded', function() {
  function updateUnreadMessageCount() {
    fetch('/messages/unread_count')
      .then(response => response.json())
      .then(data => {
        document.getElementById('unread-message-count').textContent = data.count;
      });
  }

  // Update count every 30 seconds
  setInterval(updateUnreadMessageCount, 30000);

  // Initial count update
  updateUnreadMessageCount();
});
