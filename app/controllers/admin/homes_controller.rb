class Admin::HomesController < ApplicationController
  def top
    @params = params[:id]
    @order = Order.page(params[:page])
    @search = Item.ransack(params[:q])
    @items = @search.result
  end
end
