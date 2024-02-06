class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
 
  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update!(order_detail_params)
    
    if order_detail.making_status == "in_production"
      order = Order.find_by(id: order_detail.order_id)
      order.update!(status: 2)
    end
    redirect_to admin_order_path(order_detail.order_id)
  end
  
  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
 
end
