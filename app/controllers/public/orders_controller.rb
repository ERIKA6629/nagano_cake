class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
  end
  
  def confirm
    @orders = current_customer.cart_items
    @order = Order.new(order_params)
    @shipping_fee = 800
    @total_price = 0
    if params[:order][:address_type] == "registered_address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_type] == "new_address"
      return
    end
    
  end
  
  def create
    order = Order.new(order_params)
    order.customer_id = current_customer.id
    order.save!
    
    @cart_items = current_customer.cart_items
    
    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = order.id
      @order_details.item_id = cart_item.item_id
      @order_details.amount = cart_item.amount
      @order_details.price = cart_item.item.with_tax_price
      @order_details.save!
    end
    
    current_customer.cart_items.destroy_all
    redirect_to complete_path
  end
  
  def show
  end
  
  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :name, :status, :address, :total_price, :payment_method, :shipping_fee)
  end
  
end
