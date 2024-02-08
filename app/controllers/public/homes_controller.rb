class Public::HomesController < ApplicationController
  
  def top
    items = Item.where(is_sold_out: "false")
    @items = items.last(4)
  end
  
end
