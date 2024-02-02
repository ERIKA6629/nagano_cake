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
  
  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :name, :address, :total_price, :payment_method, :shipping_fee)
  end
  
end
