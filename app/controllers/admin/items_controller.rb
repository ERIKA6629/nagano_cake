class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def new
    @item = Item.new
  end
  
  def create
    item = Item.new(item_params)
    item.save
    @item = Item.find(item.id)
    redirect_to admin_item_path(item.id)
  end
  
  def index
    @items = Item.page(params[:page])
  end
  
  def show
    @item = Item.find(params[:id])
    @include_tax = @item.price * 1.1
    @include_tax = @include_tax.to_i
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to admin_item_path(item.id)
  end
  
  private
  
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :is_sold_out)
  end
  
end
