import "@hotwired/turbo-rails"; // Turbo for fast navigation without page reloads
import "controllers";            // Stimulus controllers
import "@popperjs/core";         // Popper for Bootstrap tooltips/popovers
import "bootstrap";              // Bootstrap for dropdowns, modals, etc.
import "channels";               // ActionCable for real-time updates
import './message_form';

import * as Rails from "@rails/ujs"

Rails.start()
import "controllers"
