class FavoritesController < ApplicationController
  before_action :initialize_item, except: :index

  def index
    @items = current_user.items.favorites
  end

  def create
    @item.favorite!
    head :ok
  end

  def destroy
    @item.favorite!(false)
    head :ok
  end

  private

  def initialize_item
    @item = current_user.items.find(params[:id])
  end
end
