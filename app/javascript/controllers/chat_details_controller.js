import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat-details"
export default class extends Controller {
  static targets = ["details"];

  toggle() {
    this.detailsTarget.classList.toggle("open");
  }
}
