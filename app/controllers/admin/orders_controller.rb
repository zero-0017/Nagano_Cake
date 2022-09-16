class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:success]="注文ステータスを変更しました"
      redirect_to admin_order_path(@order)
    end
      render"show"
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
