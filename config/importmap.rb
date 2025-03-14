# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "channels", to: "channels/index.js"
pin "message_notification_channel", to: "channels/message_notification_channel.js"
pin "consumer", to: "channels/consumer.js"
pin "admin_actions_controller", to: "controllers/admin_actions_controller.js"
pin "@rails/ujs", to: "https://cdn.jsdelivr.net/npm/@rails/ujs@7.1.3-4"
pin "@rails/actioncable", to: "actioncable.js"
