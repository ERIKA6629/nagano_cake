class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save!
    redirect_to cart_items_path

  end
  
  def index
    @cart_item = CartItem.all
    @total_price = 0
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
