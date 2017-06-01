class RecentsController < ApplicationController
  def index
    @items = current_user.items.recents
  end
end
