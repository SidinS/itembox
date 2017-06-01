class ItemsController < ApplicationController
  before_action :ensure_can_upload, only: :create

  def show
    item = current_user.items.find(params[:id])
    send_file(item.file.to_s)
  end

  def create
    current_folder.items.create!(item_params.merge(user_id: current_user.id))
    head :ok
  end

  def destroy
    item = current_user.items.find(params[:id])
    item.destroy!
    redirect_to current_folder, notice: I18n.t('item.successfully_destroyed')
  end

  private

  def item_params
    params.require(:item).permit(:file) if params.key?(:item)
  end

  def current_folder
    current_user.folders.find(params[:folder_id]) if params[:folder_id]
  end

  def ensure_can_upload
    head :forbidden unless current_user.free_space?(Item.new(item_params))
  end
end
