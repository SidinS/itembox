module Users
  class SessionsController < Devise::SessionsController
    NEW_ACTION_NAME = 'new'.freeze
    REGISTRATION_CONTROLLER_NAME = 'registration'.freeze
    APPLICATION_CONTROLLER_NAME = 'application'.freeze

    layout ->(controller) { controller_layout(controller.action_name) }

    private

    def controller_layout(action_name)
      if action_name == NEW_ACTION_NAME
        REGISTRATION_CONTROLLER_NAME
      else
        APPLICATION_CONTROLLER_NAME
      end
    end
  end
end
