class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.where(order_id: params[:id])
  end
  
  def update
    order = Order.find(params[:id])
    order.update!(order_params)
    
    if order.status == "confirmed_payment"
      order.order_details.each do |order_detail|
        order_detail.update!(making_status: 1)
      end
    end
    
    redirect_to admin_order_path(order.id)
  end
  
  private
  def order_params
    params.require(:order).permit(:status)
  end
  
end
