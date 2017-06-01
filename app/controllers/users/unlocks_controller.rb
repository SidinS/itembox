module Users
  class UnlocksController < Devise::UnlocksController
    layout 'registration'.freeze
  end
end
