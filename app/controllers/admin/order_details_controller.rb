class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
 
  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update!(order_detail_params)
    order = Order.find_by(id: order_detail.order_id)
    if order_detail.making_status == "in_production"
      order.update!(status: 2)
    end
    
    if all_order_details_completed(order)
      order.update!(status: 3)
    end
    
    redirect_to admin_order_path(order_detail.order_id)
  end
  
  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
  
  def all_order_details_completed(order)
    order.order_details.each do |order_detail|
      if order_detail.making_status != "production_completed"
        return false
      end
    end
    
    return true
  end
 
end
