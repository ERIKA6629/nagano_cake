class Public::ItemsController < ApplicationController

  def index
    @items = Item.where(is_sold_out: "false")
    @items_count = @items.count{|i| i.is_sold_out? === false}
    @items = @items.page(params[:page]).per(8)
  end
  
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
