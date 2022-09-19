class Public::HomesController < ApplicationController
  def top
    @items = Item.all
    @search = Item.ransack(params[:q])
    @items = @search.result
  end

  def about
    @search = Item.ransack(params[:q])
    @items = @search.result
  end
end
