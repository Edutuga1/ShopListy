// app/assets/javascripts/settings.js
document.addEventListener('DOMContentLoaded', () => {
  const form = document.querySelector('form');
  form.addEventListener('submit', function (event) {
    const confirmAction = confirm('Are you sure you want to save changes?');
    if (!confirmAction) {
      event.preventDefault(); // Prevent form submission if the user cancels
    }
  });
});
