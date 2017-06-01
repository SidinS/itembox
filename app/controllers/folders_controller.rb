class FoldersController < ApplicationController
  before_action :set_folder, only: %i(show update destroy)

  def index
    @folder = current_user.folders.first
  end

  def show
    redirect_to folders_url if @folder == root_folder
  end

  def create
    @folder = current_user.folders.build(folder_params)

    if @folder.save
      redirect_to @folder, notice: I18n.t('folder.successfully_created')
    else
      message = @folder.errors[:base].present? ? @folder.errors[:base].first : I18n.t('folder.not_created')
      redirect_to @folder, alert: message
    end
  end

  def update
    if @folder.update_attributes(folder_params)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @folder.destroy!
    redirect_to folders_url, notice: I18n.t('folder.successfully_destroyed')
  end

  private

  def set_folder
    @folder = current_user.folders.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:title, :root_folder_id)
  end
end
