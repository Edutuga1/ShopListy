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
pin "@rails/actioncable", to: "actioncable.js"
