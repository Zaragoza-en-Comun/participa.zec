module Participa
  class Application < Rails::Application
    config.i18n.default_locale = :ca
    config.i18n.available_locales = ['es', 'ca']
    config.to_prepare do
      Devise::Mailer.layout "email"

      # Authorization endpoint
      Doorkeeper::AuthorizationsController.layout "doorkeeper/authorization"
    end
  end
end
