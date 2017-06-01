require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Itembox
  class Application < Rails::Application
    config.i18n.default_locale = 'ru-RU'.to_sym
    config.active_record.observers = %i(user_observer)
    config.active_record.raise_in_transactional_callbacks = true
    CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
    config.middleware.use I18n::JS::Middleware
  end
end
