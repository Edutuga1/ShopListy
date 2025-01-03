import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.scrollToBottom();
  }

  scrollToBottom() {
    this.element.scrollTop = this.element.scrollHeight;
  }

  // Trigger scroll after a Turbo Stream update
  initialize() {
    this.observeTurboStream();
  }

  observeTurboStream() {
    const observer = new MutationObserver(() => this.scrollToBottom());
    observer.observe(this.element, { childList: true });
  }
}
