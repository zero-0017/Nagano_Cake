class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end

  def confirm
    @order = Order.new(order_params)

  if params[:order][:address_option] == "0"
    @order.shipping_post_code = current_customer.post_code
    @order.shipping_address = current_customer.address
    @order.shipping_name = current_customer.last_name + current_customer.first_name

  elsif params[:order][:address_option] == "1"
    ship = Address.find(params[:order][:customer_id])
    @order.shipping_post_code = ship.post_code
    @order.shipping_address = ship.address
    @order.shipping_name = ship.name

  elsif params[:order][:address_option] = "2"
    @order.shipping_post_code = params[:order][:shipping_post_code]
    @order.shipping_address = params[:order][:shipping_address]
    @order.shipping_name = params[:order][:shipping_name]
  else
      render 'new'
  end
    @cart_items = current_customer.cart_items.all
    @order.member_id = current_member.id
  end

  def create
    @order = Order.new(order_params)
    @order.member_id = current_member.id
    @order.save
    current_member.cart_items.each do |cart_item|
    @ordered_item = OrderedItem.new
    @ordered_item.item_id = cart_item.item_id
    @ordered_item.quantity = cart_item.quantity
    @ordered_item.total_price = (cart_item.item.price*1.10).floor
    @ordered_item.order_id =  @order.id
    @ordered_item.save
  end
   redirect_to thanks_orders_path
   current_customer.cart_items.destroy_all
  end

  def thanks
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @ordered_items = @order.ordered_items
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :total_price, :payment_method, :postage, :shipping_post_code, :shipping_address, :shipping_name, :status)
  end
end
