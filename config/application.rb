require_relative "boot"

require "rails/all"

require 'dotenv/load'

Bundler.require(*Rails.groups)
Dotenv::Rails.load

module ShoppingList
  class Application < Rails::Application
    config.action_controller.raise_on_missing_callback_actions = false if Rails.version >= "7.1.0"
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :test_unit, fixture: false
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # I18n Configuration
    config.i18n.available_locales = [:en, :es, :pt]
    config.i18n.default_locale = :en               
    config.i18n.fallbacks = [:en]                 


    config.autoload_lib(ignore: %w(assets tasks))

    config.middleware.use OmniAuth::Builder do
      provider :google_oauth2, 'GOOGLE_CLIENT_ID', 'GOOGLE_CLIENT_SECRET', scope: 'email,profile'
    end
  end
end
