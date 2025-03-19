import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "confirmButton"];

  // Show modal on submit
  show(event) {
    event.preventDefault(); // Prevent form submission
    this.modalTarget.classList.remove("hidden"); // Show the modal
  }

  // Hide modal
  hide() {
    this.modalTarget.classList.add("hidden"); // Hide the modal
  }

  // Submit the form
  submit(event) {
    event.preventDefault(); // Prevent default action (repeated submission)
    this.element.submit(); // Submit the form
  }
}
