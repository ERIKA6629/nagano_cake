class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @orders = Order.page(params[:page])
    @order_details = OrderDetail.all
    @total_amount = 0
    
  end
  
end
