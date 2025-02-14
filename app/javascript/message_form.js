document.addEventListener('turbo:load', function() {
  const messageTextarea = document.querySelector('textarea');
  const submitButton = document.querySelector('.custom-send-btn'); // Update to use the custom button class
  const form = document.querySelector('form');

  if (!messageTextarea || !submitButton || !form) {
    console.error("Missing elements! Check your selectors.");
    return;
  }

  function updateButtonState() {
    const isEmpty = messageTextarea.value.trim() === '';
    submitButton.disabled = isEmpty;
    submitButton.classList.toggle('disabled', isEmpty);
  }

  updateButtonState();

  messageTextarea.addEventListener('input', updateButtonState);

  form.addEventListener('submit', function(event) {
    if (messageTextarea.value.trim() === '') {
      console.warn("Attempted to send an empty message.");
      event.preventDefault();
      return;
    }

    setTimeout(() => {
      messageTextarea.value = '';
      updateButtonState();
    }, 100);
  });
});
