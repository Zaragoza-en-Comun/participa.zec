Rails.application.configure do
  # Enable locale fallbacks for I18n (makes lookups for any locale fall back t
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = [:es]

  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.smtp_settings = {
    :address        => Rails.application.secrets.smtp_address,
    :port           => Rails.application.secrets.smtp_port,
    :authentication => Rails.application.secrets.smtp_authentication,
    :user_name      => Rails.application.secrets.smtp_username,
    :password       => Rails.application.secrets.smtp_password,
    :enable_starttls_auto => Rails.application.secrets.smtp_starttls_auto,
  }
end
