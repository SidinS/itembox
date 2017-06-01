module Users
  class RegistrationsController < Devise::RegistrationsController
    NEW_ACTION_NAME = 'new'.freeze
    CREATE_ACTION_NAME = 'create'.freeze
    REGISTRATION_CONTROLLER_NAME = 'registration'.freeze
    APPLICATION_CONTROLLER_NAME = 'application'.freeze

    layout ->(controller) { controller_layout(controller.action_name) }

    before_action :configure_permitted_parameters

    private

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update).push :time_zone
      devise_parameter_sanitizer.for(:account_update).push :locale_id
    end

    def controller_layout(action_name)
      if action_name == NEW_ACTION_NAME || action_name == CREATE_ACTION_NAME
        REGISTRATION_CONTROLLER_NAME
      else
        APPLICATION_CONTROLLER_NAME
      end
    end
  end
end
