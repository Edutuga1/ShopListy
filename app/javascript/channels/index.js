import { Application } from "@hotwired/stimulus";
const application = Application.start();

// Automatically register all controllers in this directory
const context = require.context("./", true, /\.js$/);
context.keys().forEach((key) => {
  const identifier = key
    .replace("./", "")
    .replace("_controller.js", "")
    .replace("/", "--");
  const controller = context(key).default;
  application.register(identifier, controller);
});

// Import and export channels here
import consumer from "./consumer";
import "./message_notification_channel";

// Optionally, you can export consumer if needed elsewhere
export { consumer };

