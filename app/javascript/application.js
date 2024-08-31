import "@hotwired/turbo-rails";
import "controllers";
import "@popperjs/core";
import "bootstrap";
import "channels"; // This should match the importmap path

document.addEventListener('DOMContentLoaded', () => {
  // Set up event listeners for delete links with confirmation
  document.querySelectorAll('a[data-method="delete"]').forEach(link => {
    link.addEventListener('click', (event) => {
      event.preventDefault();
      if (confirm(link.getAttribute('data-confirm'))) {
        fetch(link.href, {
          method: 'DELETE',
          headers: {
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
            'Accept': 'text/vnd.turbo-stream.html'
          }
        })
        .then(response => {
          if (response.ok) {
            return response.text();
          } else {
            throw new Error(`Delete request failed with status: ${response.status}`);
          }
        })
        .then(html => {
          const parser = new DOMParser();
          const doc = parser.parseFromString(html, 'text/html');
          doc.querySelectorAll('turbo-stream').forEach(stream => {
            document.head.appendChild(stream);
          });
        })
        .catch(error => {
          console.error('Error during delete request:', error);
          alert('An error occurred');
        });
      }
    });
  });
});
