class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order.postage = 800
    @order_detail = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order_status = params[:order][:order_status].to_i
    @order.update(order_status: @order_status)
    if @order_status == 1
      @order.order_details.each do |order_detail|
        order_detail.update(production_status: 1)
      end
    end
    redirect_to admin_order_path(@order)
  end

end
