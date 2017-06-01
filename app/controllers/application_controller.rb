class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :set_locale

  helper_method :current_folder, :root_folder

  protected

  def set_locale
    I18n.locale = current_user.locale.name if current_user
  end

  def root_folder
    current_user.folders.first
  end

  def current_folder
    id = params[:id] || params[:folder_id]
    folder = id ? current_user.folders.find(id) : root_folder
    FolderDecorator.decorate(folder)
  end
end
