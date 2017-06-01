class ShareController < ApplicationController
  prepend_before_action :initialize_share, except: :index
  before_action :ensure_has_access, only: :show

  skip_before_action :authenticate_user!, only: :show

  def index
    @items = current_user.items.shared
  end

  def show
    send_file(@item.file.to_s)
  end

  def create
    @item.update_attributes!(share_url: share_url(@item))
    head :ok
  end

  def destroy
    @item.update_attributes!(share_url: nil)
    head :ok
  end

  private

  def initialize_share
    @item = Item.find(params[:id])
  end

  def ensure_has_access
    head :forbidden unless @item.share?
  end
end
