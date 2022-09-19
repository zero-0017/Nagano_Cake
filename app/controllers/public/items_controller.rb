class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    @search = Item.ransack(params[:q])
    @items = @search.result
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @search = Item.ransack(params[:q])
    @items = @search.result
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :image, :introduction, :price, :is_active)
  end

end
