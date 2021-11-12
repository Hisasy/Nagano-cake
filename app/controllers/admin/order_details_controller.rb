class Admin::OrderDetailsController < ApplicationController

  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @production_status = params[:order_detail][:production_status].to_i
    @order_detail.update(production_status: @production_status)
    @order = @order_detail.order
    @order_details = OrderDetail.all
      if @production_status == 2
        @order_detail.order.update(production_status: 2)
      elsif @order.order_details.count == @order.order_details.where(production_status: 3).count
        @order_detail.order.update(production_status: 3)
      end
    redirect_to admin_order_path(@order_detail.order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end

end
