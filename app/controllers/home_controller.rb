class HomeController < ApplicationController
  def index
    path = current_user ? folders_path : new_user_session_path
    redirect_to path
  end
end
