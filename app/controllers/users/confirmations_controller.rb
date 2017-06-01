module Users
  class ConfirmationsController < Devise::ConfirmationsController
    layout 'registration'.freeze
  end
end
