class Public::ItemsController < ApplicationController

  def index
    @items = Item.all
    @items_count = @items.count{|i| i.is_sold_out? === false}
    @items = Item.page(params[:page]).per(12)
  end

end
