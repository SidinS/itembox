Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.smtp_settings = {
    authentication: :plain,
    address: 'smtp.mailgun.org',
    port: 587,
    domain: 'sandbox3e11a0c809c445ac95a4a13c0a8c1886.mailgun.org',
    user_name: 'postmaster@sandbox3e11a0c809c445ac95a4a13c0a8c1886.mailgun.org',
    password: '777f7d8730ad9d471a418bf9cf9bb640'
  }

  routes.default_url_options = { host: 'ec2-13-58-174-115.us-east-2.compute.amazonaws.com' }
  # config.secret_key_base = ENV["SECRET_KEY_BASE"]
end
