document.addEventListener('DOMContentLoaded', function() {
  const messageTextarea = document.querySelector('textarea');
  const submitButton = document.querySelector('.btn-send');
  const form = document.querySelector('form'); // Assuming your form has a submit button

  // Function to toggle button state
  function toggleSubmitButtonState() {
    // If the textarea value is empty (or just whitespace), disable the button and apply the "disabled" class
    if (messageTextarea.value.trim() === '') {
      submitButton.classList.add('disabled');  // Add the disabled class
      submitButton.disabled = true;  // Optionally also disable the button
    } else {
      submitButton.classList.remove('disabled');  // Remove the disabled class
      submitButton.disabled = false;  // Enable the button
    }
  }

  // Disable submit button initially if the textarea is empty
  toggleSubmitButtonState();

  // Event listener to monitor input and update the button state
  messageTextarea.addEventListener('input', function() {
    toggleSubmitButtonState();
  });

  // Event listener to reset button state after submitting a message
  form.addEventListener('submit', function(event) {
    // Ensure the button is disabled after sending a message if textarea is empty
    toggleSubmitButtonState();

    // Allow time for form submission and resetting
    setTimeout(function() {
      messageTextarea.value = ''; // Clear textarea after message sent
      toggleSubmitButtonState();  // Recheck button state after clearing
    }, 100);  // 100ms delay to ensure the form has time to process
  });
});
