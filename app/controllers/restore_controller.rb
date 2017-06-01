class RestoreController < ApplicationController
  def index
    @items = current_user.items.only_deleted
  end

  def update
    restore_service = RestoreService.new(current_user, params[:id])
    restore_service.restore
    redirect_to restore_service.folder
  end
end
